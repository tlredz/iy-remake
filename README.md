# 🪄 Infinite Yield RV (Remake Version)

> [!IMPORTANT]
> **Infinite Yield RV** was built using a modular structure.
> To compile the code, you must use a Lua/Luau bundler, or run it locally by placing the project inside your executor's folder.

> [!TIP]
> Suggestions and pull requests are highly welcome! Feel free to contribute to improve and fix the project.

> [!WARNING]
> **Infinite Yield RV** is currently **UNDER DEVELOPMENT**.
> There is no official release date yet, and you may encounter bugs.

## 📌 About
- **Infinite Yield** is a feature-rich admin command panel designed for Roblox games.
- **Infinite Yield RV** is a completely rewritten remake focused on modern practices.

- 🔹 **Original Project:** Created by **edges**
- 🔹 **Remake Version:** Developed by **real_redz** (Redz Hub Team)
- 🔹 **Key Features:** Open-Source, Lightweight, and Optimized  

---

## 🚀 Getting Started

To load and run the compiled version of **Infinite Yield RV**, execute the following script:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/iy-remake/refs/heads/main/compiled.luau"))()
```
## 💻 Running Locally (Development)
To run and test the project locally, clone or download the repository and place it inside your executor's folder using the following structure:
 * your_executor/
   * workspace/
     * iy-remake/
     * robloxBundle.luau *(optional)*

After setting up the directory, you can execute the script using the bootstrap code below:

```luau
-- Fetching the Luau bundler environment
-- This bundle allows you to use a modular file structure (require) locally.

-- Optional: Load the bundle from your local workspace folder instead:
-- local bundle = loadstring(readfile("robloxBundle.luau"))()

-- Fetching the Luau bundle directly from the GitHub repository:
local bundle = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/projects/refs/heads/main/robloxBundle.luau"))()

-- Creating a environment chunk to handle 'require' statements.
-- If you renamed the project folder, change "iy-remake" to your folder's name.
local require = bundle.new("iy-remake").require

-- Initializing Infinite Yield Core
local infiniteYield = require("./src/core/iy")

-- Initializing and configuring the Logger Utility
local logger = require("./src/utils/logger")

logger:enable() -- Ensures the logger is enabled
logger:log("Hello from Infinite Yield!")
```
