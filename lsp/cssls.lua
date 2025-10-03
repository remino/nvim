local nvlsp = require "nvchad.configs.lspconfig"

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
