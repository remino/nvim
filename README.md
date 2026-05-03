# remino/nvim

Fork of [NvChad/starter](https://github.com/nvchad/starter) config for Neovim.

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

### Minuet

Minuet can be customized locally with `lua/local/llm.lua` as the shared source
of truth, then wired through `lua/local/minuet.lua`:

```lua
-- lua/local/minuet.lua
local llm = require("local.llm")

return {
	provider = "openai_fim_compatible",
	provider_options = {
		openai_fim_compatible = {
			api_key = llm.api_key,
			name = "Ollama",
			end_point = llm.minuet_endpoint,
			model = llm.minuet_model,
		},
	},
}
```

### Avante

Avante is included as an optional plugin spec, but disabled by default because it
is provider-specific and has extra build/runtime dependencies. Enable it locally:

```lua
-- lua/local/avante.lua
local llm = require("local.llm")

return {
	enabled = true,
	opts = {
		mode = "legacy",
		provider = "ollama",
		auto_suggestions_provider = "ollama",
		providers = {
			ollama = {
				endpoint = llm.endpoint,
				model = llm.avante_model,
			},
		},
	},
}
```
