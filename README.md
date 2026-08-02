# remino/nvim

Fork of [NvChad/starter](https://github.com/nvchad/starter) config for Neovim.

## Installing on another machine

Copy or clone the whole repository, including `lazy-lock.json`, then start
Neovim and run `:Lazy sync`. The lockfile keeps plugin versions identical
between machines.

This config supports Neovim 0.10 and newer. On a machine with Neovim 0.11+ it
uses the built-in LSP configuration API; on 0.10 it automatically falls back to
`nvim-lspconfig`'s compatible API.

### Quiet startup and troubleshooting

Startup should be quiet when the configuration is valid. If something looks
wrong, inspect it when you choose instead of trying to read a disappearing
startup notification:

- `:messages` — errors and warnings from this Neovim session
- `:Lazy` — plugin install/update/load errors
- `:checkhealth` — Neovim, provider, and plugin health checks
- `:LspBufferStatus` — LSP clients attached to the current buffer

### OSC 52 clipboard

This config enables OSC 52 by default so remote Neovim sessions can use your
local system clipboard. Some terminals block OSC 52 clipboard reads, which can
leave Neovim showing `Waiting for OSC 52` when you paste from the `+` register.

- `:Osc52Disable` (or `<leader>uo`) disables OSC 52 for the current session.
  Normal terminal paste and Neovim's unnamed register still work.
- `:Osc52Enable` restores it for the current session.

## Local overrides

This repository is meant to be public and reusable. Machine-specific settings
belong in ignored local files:

- `lua/local.lua`
- `lua/local/*.lua`

The old `lua/local.lua` entry point still loads before plugins for compatibility.
For new overrides, prefer the more specific modules below.
`lua/local` is ignored without a trailing slash, so it can be either a directory
or a symlink.

### Startup hooks

```lua
-- lua/local/before.lua
vim.g.some_plugin_flag = true
```

```lua
-- lua/local/after.lua
vim.notify "Local config loaded"
```

### Options

```lua
-- lua/local/options.lua
vim.o.colorcolumn = "100"
vim.o.cursorcolumn = false
```

### Mappings

```lua
-- lua/local/mappings.lua
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
```

### Plugins

Return extra lazy.nvim plugin specs from `lua/local/plugins.lua`:

```lua
-- lua/local/plugins.lua
return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
	},
}
```

Personal plugins that need local paths also belong here:

```lua
-- lua/local/plugins.lua
return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			workspaces = {
				{ name = "notes", path = "~/Vault" },
			},
		},
	},
}
```

### AI setup

Use one ignored file to keep Copilot enabled on this machine:

```lua
-- lua/local/ai.lua
return {
	backend = "copilot",
}
```

You can also drive this from the shell with `NVIM_AI_BACKEND=copilot nvim`.

- `copilot` enables:

- `github/copilot.vim` for inline completions

Inside Neovim, run `:AiHealth` for the quick Copilot checklist. For deeper checks,
use `:checkhealth copilot` and `:Copilot status`.

### Formatter config

`lua/local/conform.lua` is deep-merged into the shared Conform config:

```lua
-- lua/local/conform.lua
return {
	formatters_by_ft = {
		ruby = { "rubocop" },
	},
}
```

### LSP config

`lua/local/lsp.lua` is deep-merged into the shared LSP config:

```lua
-- lua/local/lsp.lua
return {
	servers = {
		"astro",
		"html",
		"eslint",
		"tailwindcss",
		"vue_ls",
		"ruby_lsp",
	},
	server_configs = {
		ruby_lsp = {
			init_options = {
				formatter = "auto",
			},
		},
	},
	open_diagnostic_on_cursor_hold = false,
}
```

Use `lua/local/lsp_after.lua` for setup that cannot be expressed as data.

### ESLint

The `eslint` LSP only starts when `vscode-eslint-language-server` is available.
This config checks for it in:

- Mason: `stdpath("data") .. "/mason/bin/vscode-eslint-language-server"`
- Your shell `PATH`

If neither exists, Neovim skips the `eslint` server instead of showing a spawn
error.

Inside Neovim, run `:EslintStatus` to check:

- whether Mason has the binary
- whether it exists on your `PATH`
- which command path Neovim resolved
- whether an `eslint` LSP client is attached to the current buffer

If ESLint is missing, install one of these:

- `:MasonInstall eslint-lsp`
- a global npm package that provides `vscode-eslint-language-server`

After installation, restart Neovim and run `:EslintStatus` again.

### Orgmode

Orgmode is disabled in the public config because note paths are personal. Enable
it locally:

```lua
-- lua/local/orgmode.lua
return {
	enabled = true,
	opts = {
		org_agenda_files = "~/orgfiles/**/*",
		org_default_notes_file = "~/orgfiles/refile.org",
	},
}
```
