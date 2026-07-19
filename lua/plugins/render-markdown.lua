return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		config = function(_, opts)
			local colors = require("base46").get_theme_tb "base_30"

			vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = colors.one_bg })
			vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { fg = colors.line, bg = colors.one_bg })
			vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = colors.one_bg })

			require("render-markdown").setup(opts)
		end,
		opts = {
			code = {
				border = "thin",
			},
		},
	},
}
