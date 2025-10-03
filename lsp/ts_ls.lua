-- Set up ts_ls LSP with @vue/typescript-plugin

local nvlsp = require "nvchad.configs.lspconfig"

-- Dynamically point to the path of @vue/language-server
-- which contains @vue/typescript-plugin
local vue_typescript_plugin =
	vim.fn.expand(vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server")

return {
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
