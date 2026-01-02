return {
	{
		"hedyhli/markdown-toc.nvim",
		ft = "markdown", -- Lazy load on markdown filetype
		cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
		opts = {
			toc_list = {
				indent_size = 4,
				markers = "-",
			},
		},
	},
}
