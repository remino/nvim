vim.api.nvim_create_user_command("CopilotToggle", function()
	require("copilot.suggestion").toggle_auto_trigger()
end, { nargs = "*" })

return {
	-- {
	-- 	"github/copilot.vim",
	-- 	lazy = false,
	-- },
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot", "CopilotToggle" },
		event = "InsertEnter",
		config = function()
			require("copilot").setup {}
		end,
		keys = {
			{ "n", "<leader>cs", "<cmd>CopilotToggle<cr>", desc = "Toggle Copilot suggestions" },
		},
	},
}
