return {
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		keys = {
			{
				"<leader>zz",
				"<Cmd>ZenMode<CR>",
				mode = "",
				desc = "Zen Mode",
			},
		},
		opts = {
			plugins = {
				options = {
					ruler = false,
					laststatus = 0,
				},
			},
			window = {
				options = {
					number = false,
				},
			},
			on_close = function()
				if vim.g.ibl_enabled then
					vim.cmd "IblEnable"
				else
					vim.cmd "IblDisable"
				end
			end,
			on_open = function()
				vim.g.ibl_enabled = require("ibl.config").get_config(0).enabled
				vim.cmd "IblDisable"
			end,
		},
	},
}
