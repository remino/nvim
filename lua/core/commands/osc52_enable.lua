local clipboard = require "core.commands.clipboard"

vim.api.nvim_create_user_command("Osc52Enable", function()
	vim.g.clipboard = "osc52"
	local termfeatures = vim.g.termfeatures or {}
	termfeatures.osc52 = true
	vim.g.termfeatures = termfeatures
	clipboard.reload_provider()
	vim.notify("OSC 52 clipboard enabled for this session", vim.log.levels.INFO, { title = "Clipboard" })
end, { desc = "Enable OSC 52 clipboard queries for this session" })
