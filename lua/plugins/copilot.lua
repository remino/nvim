local ai_provider = require("utils.ai_provider")

return {
	{
		"github/copilot.vim",
		enabled = ai_provider.is("copilot"),
		event = "InsertEnter",
		cmd = { "Copilot" },
		init = function()
			vim.g.copilot_enabled = 0
			vim.g.copilot_no_tab_map = true

			vim.cmd [[imap <silent><script><nowait><expr> <C-Y> copilot#Accept("\<C-Y>")]]
		end,
		config = function()
			-- This plugin is loaded after VimEnter, so its VimEnter autocmd never
			-- runs. Start its client explicitly instead of waiting for :Copilot status.
			vim.fn["copilot#Init"]()
		end,
	},
}
