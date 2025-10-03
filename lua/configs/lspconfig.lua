-- See this article for details on lspconfig.lua:
-- https://remino.net/bits/neovim-vue-3-typescript/

-- Load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Dynamically point to the path of @vue/language-server
-- which contains @vue/typescript-plugin
local vue_typescript_plugin =
	vim.fn.expand(vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server")

-- Set up ts_ls LSP with @vue/typescript-plugin
vim.lsp.config("ts_ls", {
	on_attach = nvlsp.on_attach,
	on_init = nvlsp.on_init,
	capabilities = nvlsp.capabilities,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_typescript_plugin,
				languages = { "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
	settings = {
		typescript = {
			tsserver = {
				useSyntaxServer = false,
			},
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

vim.lsp.enable "ts_ls"

-- Set up CSS LSP
vim.lsp.config("cssls", {
	on_attach = nvlsp.on_attach,
	on_init = nvlsp.on_init,
	capabilities = nvlsp.capabilities,
	settings = {
		css = {
			lint = {
				-- Disable check of at rules in CSS because of Tailwind
				unknownAtRules = "ignore",
			},
		},
	},
})

vim.lsp.enable "cssls"

-- Setup other LSPs with defaults
local servers = {
	"html",
	"emmet_language_server",
	"eslint",
	"tailwindcss",
	"volar",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})

	vim.lsp.enable(lsp)
end

-- Thanks to @naborisk for the following

-- https://github.com/naborisk/dotfiles/blob/383041e06c070d78e4d990b662cfa13d35ce0a64/nvim/after/plugin/nvim-lspconfig.lua#L158
vim.diagnostic.config {
	virtual_text = false, -- Show text after diagnostics
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		header = "",
	},
}

-- Show diagnostics text on cursor hold
local lspGroup = vim.api.nvim_create_augroup("Lsp", { clear = true })

-- https://github.com/naborisk/dotfiles/blob/383041e06c070d78e4d990b662cfa13d35ce0a64/nvim/after/plugin/nvim-lspconfig.lua#L169-L172
vim.api.nvim_create_autocmd("CursorHold", {
	command = "lua vim.diagnostic.open_float()",
	group = lspGroup,
})
