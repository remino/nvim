return {
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = function()
			return require "configs.git-blame"
		end,
	},
}
