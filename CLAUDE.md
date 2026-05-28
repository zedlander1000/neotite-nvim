# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using Lua, built around [lazy.nvim](https://github.com/folke/lazy.nvim). Primarily targets Elixir/Phoenix development with full LSP, completion, formatting, and git tooling.

## Development Workflow

Changes take effect on next Neovim launch or `:Lazy reload`. No build step needed.

**Formatting Lua files:**
```bash
stylua lua/ --config-path .stylua.toml
```
Stylua settings: 2-space indent, 160 column width, single-quote preference, no call parentheses.

## Architecture

**Entry point:** `init.lua` — requires config modules in order: `options` → `keymaps` → `autocmd` → `lazy` → `lsp`.

**Config layer** (`lua/config/`): Editor options, global keymaps, autocommands, lazy.nvim bootstrap, and LSP attach callbacks/diagnostics. These are not plugin specs.

**Plugin specs** (`lua/plugins/`): One file per plugin or logical group. Each file returns a lazy.nvim spec table. LSP-related plugin specs are isolated in `lua/plugins/lsp/`.

**Language overrides** (`after/`): Per-LSP settings go in `after/lsp/<server>.lua` (e.g., `elixirls.lua`, `tailwindcss.lua`). Filetype overrides go in `after/ftplugin/<ft>.lua`.

## Plugin Management

Leader key is `<space>`. Plugins are installed/updated via `:Lazy`. LSP servers, formatters, and linters are managed by Mason — see `lua/plugins/lsp/mason.lua` for the installed tool list.

**Adding a plugin:** Create a new file in `lua/plugins/` returning a lazy.nvim spec. It will be auto-imported via the `plugins` import in `lua/config/lazy.lua`.

**Adding an LSP server:** Add the server name to the `ensure_installed` list in `lua/plugins/lsp/mason.lua`. Server-specific settings (if needed) go in `after/lsp/<server>.lua`.

## Key Conventions

- **Keymap groups** are declared in `lua/plugins/which-key.lua` and use `<leader>` prefix: `s` = Search, `c` = Code, `h` = Git Hunk, `t` = Toggle, `r` = Rename, `d` = Document, `w` = Workspace.
- **LSP keymaps** (`grn`, `gra`, `grr`, `gri`, `grd`) are set in `lua/config/lsp.lua` inside the `LspAttach` autocmd, not in individual plugin files.
- **Formatting** is handled by conform.nvim (`lua/plugins/conform.lua`) with format-on-save. Elixir linting (Credo) runs through none-ls (`lua/plugins/nonels.lua`).
- **Elixir-specific:** Indent is 2 spaces (overriding global 4) via `after/ftplugin/elixir.lua`. ElixirLS runs with `MIX_ENV=dev`.
- **Completion** uses nvim-cmp with LuaSnip, path, and LSP sources. Snippet definitions belong in `lua/plugins/luasnip.lua`.
- **Custom tree-sitter queries** for Elixir/HEEx live in `queries/`.
