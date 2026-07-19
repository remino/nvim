local ai_provider = require("utils.ai_provider")

return {
	{
		"github/copilot.vim",
		enabled = ai_provider.is("copilot"),
		event = "InsertEnter",
		cmd = { "Copilot" },
		init = function()
			vim.g.copilot_no_tab_map = true

			vim.cmd [[imap <silent><script><nowait><expr> <C-Y> copilot#Accept("\<C-Y>")]]
		end,
	},
}
