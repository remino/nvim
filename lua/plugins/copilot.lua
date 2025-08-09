return {
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot", "CopilotToggle" },
		event = "InsertEnter",
		config = function()
			vim.api.nvim_create_user_command("CopilotToggle", function()
				require("copilot.suggestion").toggle_auto_trigger()
			end, { nargs = "*" })

			require("copilot").setup {
				suggestion = {
					keymap = {
						accept = "<C-:>",
					},
				},
			}
		end,
		keys = {
			{
				"<leader>cs",
				"<cmd>CopilotToggle<cr>",
				mode = "n",
				desc = "Toggle Copilot suggestions",
			},
		},
	},
}
