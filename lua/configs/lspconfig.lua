-- See this article for details on lspconfig.lua:
-- https://remino.net/bits/neovim-vue-3-typescript/

-- Load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
local local_config = require "utils.local_config"

local config = local_config.merge({
	servers = {
		"astro",
		"html",
		"emmet_language_server",
		"eslint",
		"tailwindcss",
		"vue_ls",
	},
	server_configs = {},
	diagnostic = {
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = false,
		float = {
			border = "rounded",
			header = "",
		},
	},
	open_diagnostic_on_cursor_hold = true,
}, "local.lsp")

local function with_defaults(server_config)
	return vim.tbl_deep_extend("force", {
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	}, server_config or {})
end

-- Configure ts_ls before enabling it
vim.lsp.config(
	"ts_ls",
	with_defaults(vim.tbl_deep_extend("force", {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = function(fname)
			local util = require "lspconfig.util"
			return util.root_pattern("tsconfig.json", "package.json", ".git")(fname)
		end,
	}, config.server_configs.ts_ls or {}))
)

vim.lsp.config(
	"cssls",
	with_defaults(vim.tbl_deep_extend("force", {
		settings = {
			css = {
				lint = {
					unknownAtRules = "ignore",
				},
			},
		},
	}, config.server_configs.cssls or {}))
)

vim.lsp.enable { "ts_ls", "cssls" }

-- Setup other LSPs with defaults
-- lsps with default config
for _, lsp in ipairs(config.servers) do
	vim.lsp.config(lsp, with_defaults(config.server_configs[lsp]))

	vim.lsp.enable(lsp)
end

-- Thanks to @naborisk for the following

-- https://github.com/naborisk/dotfiles/blob/383041e06c070d78e4d990b662cfa13d35ce0a64/nvim/after/plugin/nvim-lspconfig.lua#L158
vim.diagnostic.config(config.diagnostic)

-- Show diagnostics text on cursor hold
if config.open_diagnostic_on_cursor_hold then
	local lspGroup = vim.api.nvim_create_augroup("Lsp", { clear = true })

	-- https://github.com/naborisk/dotfiles/blob/383041e06c070d78e4d990b662cfa13d35ce0a64/nvim/after/plugin/nvim-lspconfig.lua#L169-L172
	vim.api.nvim_create_autocmd("CursorHold", {
		command = "lua vim.diagnostic.open_float()",
		group = lspGroup,
	})
end

local_config.run "local.lsp_after"
