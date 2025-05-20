-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local vue_typescript_plugin =
	vim.fn.expand(vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server")

lspconfig.ts_ls.setup {
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
}

local servers = {
	"html",
	"cssls",
	"emmet_language_server",
	"eslint",
	"tailwindcss",
	"volar",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
	pcall(lspconfig[lsp].setup, {
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

-- Thanks to @naborisk for this bit
vim.diagnostic.config {
	virtual_text = false, -- show text after diagnostics
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true,
}

-- Show diagnostics text on cursor hold
local lspGroup = vim.api.nvim_create_augroup("Lsp", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
	command = "lua vim.diagnostic.open_float()",
	group = lspGroup,
})
