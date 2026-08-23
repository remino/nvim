return {
	{
		"folke/twilight.nvim",
		opts = {
			-- Neovim 0.12 can return no parser for some buffers without raising an error.
			-- Twilight does not handle that case, so use its safe line-based fallback.
			treesitter = false,
		},
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
		keys = {
			{
				"<leader>tw",
				"<Cmd>Twilight<CR>",
				mode = "",
				desc = "Toggle Twilight",
			},
		},
	},
}
