local ai_provider = require("utils.ai_provider")

return {
	{
		"zbirenbaum/copilot.lua",
		enabled = ai_provider.is("copilot"),
		event = "InsertEnter",
		cmd = { "Copilot" },
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-y>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-e>",
				},
			},
			panel = {
				enabled = false,
			},
		},
	},
}
