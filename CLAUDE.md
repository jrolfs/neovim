# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal Neovim configuration managed as a [homesick](https://github.com/technicalpickles/homesick) castle. The `home/` directory is symlinked into `~` by homesick, so `home/.config/nvim/` becomes `~/.config/nvim/`. Plugin management uses Neovim's built-in `vim.pack` (0.12+), with a lockfile (`nvim-pack-lock.json`) checked into the config directory.

## Architecture

### Multi-Environment Init System

There are three separate entry points, each loading a tailored subset of plugins and configuration:

- **`init.vim`** — Full Neovim (terminal). Loads all plugins via `lua/packages/terminal.lua`, all settings, and `lua/init.lua`.
- **`init-vscode.vim`** — VS Code via [vscode-neovim](https://github.com/vscode-neovim/vscode-neovim). Loads a minimal set of motion/editing plugins via `lua/packages/vscode.lua`. Maps Neovim leader bindings to VS Code commands via `VSCodeCall()`.
- **`init-kitty.vim`** — Kitty terminal scrollback via [kitty-scrollback.nvim](https://github.com/mikesmithgh/kitty-scrollback.nvim). Loads plugins via `lua/packages/kitty.lua`.

Each init file sets `g:init` to its own filename so the `<leader>C` hot-reload command (in `plugin/configuration.vim`) re-sources the correct entry point.

### VimScript Layer (`settings/`, `mappings/`, `plugin/`)

Shared VimScript sourced via `runtime`:

- **`settings/globals.vim`** — XDG data home detection
- **`settings/common.vim`** — Leader key (Space), undo, indentation, search, wildignore. Sets `g:lua_home` for the Lua layer.
- **`settings/interface.vim`** — UI options (cursorline, signcolumn, termguicolors)
- **`mappings/common.vim`** — Shared keybindings (quickfix/loclist navigation, `[b`/`]b`/`[w`/`]w`, EasyAlign)
- **`plugin/configuration.vim`** — `FlushLuaCache()` and `<leader>C` hot-reload mapping

### Lua Layer (`lua/`)

- **`lua/packages/common.lua`** — Plugin specs shared by all three environments, returned as a table.
- **`lua/packages/{terminal,vscode,kitty}.lua`** — Environment-specific plugin lists. Each extends common and calls `vim.pack.add()`.
- **`lua/init.lua`** — Sets up lazydev, globs and sources all files under `lua/plugins/*/`, then sets the colorscheme.
- **`lua/plugins/{category}/{plugin}.lua`** — Plugin configs organized by category: `interface/`, `lsp/`, `search/`, `syntax/`, `language/`. The `relative-source.lua` helper auto-discovers and sources these via glob patterns.
- **`lua/code/{category}/{plugin}.lua`** — VS Code–specific plugin config (mirrors the `plugins/` structure for bindings mapped to VS Code equivalents).
- **`lua/utilities.lua`** — Helpers: `merge()`, `map()`, `map_buffer()`, `map_vs()` (wraps `VSCodeCall`/`VSCodeNotify`).

### Key Conventions

- **Leader**: Space (`<leader>`), Local leader: comma (`<localleader>`)
- Plugin management: `vim.pack` (`:lua vim.pack.update()`, lockfile at `nvim-pack-lock.json`)
- LSP: `lazy-lsp.nvim` wraps `nvim-lspconfig` for automatic server setup
- Completion: `nvim-cmp` with buffer, cmdline, path, and LSP sources
- Colorscheme: gruvbox-material (default, stored in `vim.g.colorscheme`)
- Transparent background highlights are defined in `plugin/highlights.vim`

## Commit Style

Follows conventional commits: `feat(scope):`, `fix(scope):`, `chore(scope):` where scope is typically the plugin or area name (e.g., `oil`, `vscode`, `lazy-lsp`, `interface`).
