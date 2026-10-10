Sim. A ordem abaixo começa pelo que afeta tudo e termina no que mexe com hooks, porque hooks não dá para desfazer sem reiniciar.

**1. Base (teste primeiro)**
- `marktested <nome>` e `unmarktested <nome>`. Confira se o comando marcado fica cinza e se a marca continua depois de reabrir o executor (arquivo `infiniteYield/testedCommands.json`).
- Um comando sem `run` continua vermelho. Se algum comando novo aparecer vermelho, é porque o `run` não foi registrado.

**2. Movimento e viagem (uso mais frequente)**
- `fly`, `flyspeed`, `unfly`, `vehiclefly`. Todos usam o mesmo helper (`systems/flight.luau`). Confira se WASD segue a câmera e se Q/E sobem e descem.
- `noclip` e `unnoclip`. Depois de `unnoclip` as peças devem voltar a colidir.
- `float`, `unfloat`. Segurar E sobe a plataforma e segurar Q baixa.
- `goto`, `tweengoto`, `loopgoto`, `unloopgoto`. O loop usa o `loopService`, então `breakloops` também deve parar.
- `clientbring` e `loopbring`, `unloopbring` sem argumento deve limpar todos.
- `tpwalk` e `untpwalk`.

**3. Câmera**
- `view`, `viewpart`, `unview`. O spectate fica reaplicando o alvo. Confira se `fixcam` para o spectate.
- `lookat` restaura o zoom depois de virar a câmera.
- `fov` (sem argumento deve usar 70).

**4. Dependem de exploit ou mexem em hooks (teste por último)**
- `god`. Troca o Humanoid e atribui `LocalPlayer.Character`. Pode não funcionar em alguns executores.
- `spoofspeed` e `spoofjumppower`. Instalam hooks em `__index` e `__newindex` que não são removidos depois. Use em uma sessão que você possa reiniciar.
- `clientantikick` e `clientantiteleport`. Também instalam hooks permanentes.
- `noclipcam`. Depende de `getgc` e `setconstant`, e rodar de novo inverte o efeito.
- `clearhats`, `hatspin`, `handlekill`. Dependem de `firetouchinterest`.

**Pontos que já sei que podem divergir do IY**

- A velocidade do `fly` é em studs/s, com padrão 20. O IY original multiplica por 50, então `flyspeed` aqui tem outra escala.
- `viewpart` usa a primeira peça com o nome. O IY acaba na última.
- `delete` e `deleteclass` só cancelam se `confirm` for `false`.

Não rodei nada no Roblox, então qualquer um desses pode falhar. Se algo quebrar, me manda o nome do comando e a mensagem de erro que aparecer no console.