return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"astro",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"sql",
			},
			highlight = {
				enable = true,
			},
		},
	},
	{
		"DariusCorvus/tree-sitter-language-injection.nvim",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
		init = function()
			-- LSP semantic tokens can repaint an injected region as one string after
			-- it attaches. Leave strings to Tree-sitter so the embedded language stays
			-- highlighted while preserving semantic tokens for everything else.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("TreeSitterLanguageInjection", { clear = true }),
				callback = function()
					vim.api.nvim_set_hl(0, "@lsp.type.string", {})
				end,
			})
		end,
	},
}
