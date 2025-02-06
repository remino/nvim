return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			return require "configs.indent-blankline"
		end,
	},
}
