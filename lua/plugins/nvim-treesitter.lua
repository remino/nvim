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
			},
			highlight = {
				enable = true,
			},
		},
	},
}
