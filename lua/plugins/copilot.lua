return {
	-- {
	-- 	"github/copilot.vim",
	-- 	lazy = false,
	-- },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup {}
		end,
	},
}
