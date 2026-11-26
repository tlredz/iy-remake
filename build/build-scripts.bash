#!/usr/bin/env bash
# build-scripts.bash: builds backups/scripts into backups/compiled.
#   a .luau file at the top of scripts/ becomes one file: compiled/<name>.luau
#   a folder of scripts/ becomes one file, built from its main.luau: compiled/<folder>.luau
#     the other .luau files of the folder are modules that main.luau requires, so they are joined into that file
#   1. darklua (when found): joins the requires into the file (bundle) and minifies it, with darklua.json
#      without darklua a folder cannot be built, and the single files are copied as they are
#   2. lumarge (when found, and only after darklua): minifies the darklua output again:
#        lumarge obfuscate -p minify -v luau <input> <output>
#      the darklua output is written under another name first, so the input and the output never have the same name
#   a bundle that still has a require of a local module (require("./x")) is an error: its modules were not joined
#   files that are not scripts (anything but .luau and .lua) are copied to the same path in compiled/
#   compiled is made again on every run, so a script removed from scripts/ is removed from compiled/ too
#
# usage: ./build/build-scripts.bash
# darklua is looked for in DARKLUA (if set), then the PATH, then the project folder, then ~/.cargo/bin
# lumarge is looked for in LUMARGE (if set), then the PATH, then the project folder
# a script that fails is reported, the others are still built, and the exit code is 1

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/backups/scripts"
OUT="$ROOT/backups/compiled"
CONFIG="$ROOT/darklua.json"

find_darklua() {
	if [ -n "${DARKLUA:-}" ]; then
		echo "$DARKLUA"
	elif command -v darklua >/dev/null 2>&1; then
		command -v darklua
	elif [ -x "$ROOT/darklua" ]; then
		echo "$ROOT/darklua"
	elif [ -x "$HOME/.cargo/bin/darklua" ]; then
		echo "$HOME/.cargo/bin/darklua"
	else
		return 1
	fi
}

find_lumarge() {
	if [ -n "${LUMARGE:-}" ]; then
		echo "$LUMARGE"
	elif command -v lumarge >/dev/null 2>&1; then
		command -v lumarge
	elif [ -x "$ROOT/lumarge" ]; then
		echo "$ROOT/lumarge"
	else
		return 1
	fi
}

# true when a file still has a require of a local module: require("./x") or require './x'
has_local_require() {
	grep -Eq 'require[[:space:]]*\(?[[:space:]]*["'"'"']\./' "$1"
}

# builds one output file. file is the source (a single file, or the main.luau of a folder), dest is the output in
# compiled/. Returns 1 when a tool fails or the bundle still has a require of a local module
build_file() {
	local file="$1"
	local dest="$2"
	local name="${dest##*/}"
	local stem="${name%.*}"
	local ext="${name##*.}"
	local bundled

	mkdir -p "$(dirname "$dest")"

	if [ -z "$DARKLUA_BIN" ]; then
		cp "$file" "$dest"
		return 0
	fi

	if [ -z "$LUMARGE_BIN" ]; then
		bundled="$dest"
	else
		# the darklua output gets another name, so lumarge never reads and writes the same name
		bundled="$TMP/$stem.darklua.$ext"
	fi

	if ! "$DARKLUA_BIN" process "$file" "$bundled" -c "$CONFIG"; then
		rm -f "$dest"
		return 1
	fi

	if has_local_require "$bundled"; then
		echo "the bundle of $name still has a require of a local module, so its modules were not joined" >&2
		rm -f "$dest"
		return 1
	fi

	if [ -n "$LUMARGE_BIN" ]; then
		if ! "$LUMARGE_BIN" obfuscate -p minify -v luau "$bundled" "$dest"; then
			rm -f "$dest"
			return 1
		fi
	fi

	return 0
}

if [ ! -d "$SRC" ]; then
	echo "folder not found: backups/scripts" >&2
	exit 1
fi

DARKLUA_BIN="$(find_darklua)" || DARKLUA_BIN=""
LUMARGE_BIN="$(find_lumarge)" || LUMARGE_BIN=""

if [ -n "$DARKLUA_BIN" ]; then
	if [ ! -f "$CONFIG" ]; then
		echo "darklua.json not found at $CONFIG" >&2
		exit 1
	fi
	echo "darklua: $("$DARKLUA_BIN" --version)"
	if [ -n "$LUMARGE_BIN" ]; then
		echo "lumarge: $LUMARGE_BIN"
	fi
else
	echo "warning: darklua was not found. Single files are copied as they are, and folders cannot be built" >&2
	if [ -n "$LUMARGE_BIN" ]; then
		echo "warning: lumarge is not used, it needs the darklua output" >&2
	fi
	LUMARGE_BIN=""
fi

TMP="$(mktemp -d)" || exit 1
trap 'rm -rf "$TMP"' EXIT

rm -rf "$OUT"
mkdir -p "$OUT"

built=0
failed=0

# single scripts at the top of scripts/: one output file each
while IFS= read -r -d '' file; do
	name="${file##*/}"
	case "$name" in
		*.luau|*.lua)
			before="$(wc -c < "$file")"
			if build_file "$file" "$OUT/$name"; then
				printf '%s: %s -> %s bytes\n' "$name" "$before" "$(wc -c < "$OUT/$name")"
				built=$((built + 1))
			else
				echo "FAILED: $name" >&2
				failed=$((failed + 1))
			fi
			;;
	esac
done < <(find "$SRC" -mindepth 1 -maxdepth 1 -type f -print0 | sort -z)

# folders of scripts/: one output file each, built from main.luau, with the other .luau files joined into it
while IFS= read -r -d '' dir; do
	name="${dir##*/}"
	main="$dir/main.luau"

	if [ ! -f "$main" ]; then
		echo "FAILED: $name/ has no main.luau, the file the folder is built from" >&2
		failed=$((failed + 1))
		continue
	fi

	if [ -z "$DARKLUA_BIN" ]; then
		echo "FAILED: $name/ needs darklua to join its modules" >&2
		failed=$((failed + 1))
		continue
	fi

	before=0
	modules=""
	for module in "$dir"/*.luau "$dir"/*.lua; do
		[ -f "$module" ] || continue
		before=$((before + $(wc -c < "$module")))
		if [ "${module##*/}" != "main.luau" ]; then
			modules="$modules ${module##*/}"
		fi
	done

	if build_file "$main" "$OUT/$name.luau"; then
		printf '%s/ -> %s.luau: %s -> %s bytes (modules joined:%s)\n' \
			"$name" "$name" "$before" "$(wc -c < "$OUT/$name.luau")" "${modules:- none}"
		built=$((built + 1))
	else
		echo "FAILED: $name/" >&2
		failed=$((failed + 1))
	fi
done < <(find "$SRC" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

# files that are not scripts keep their path
while IFS= read -r -d '' file; do
	rel="${file#"$SRC"/}"
	mkdir -p "$(dirname "$OUT/$rel")"
	cp "$file" "$OUT/$rel"
	echo "copied: $rel"
done < <(find "$SRC" -type f ! -name '*.luau' ! -name '*.lua' -print0 | sort -z)

echo "$built file(s) built into backups/compiled"

if [ "$failed" -gt 0 ]; then
	echo "$failed failed" >&2
	exit 1
fi
