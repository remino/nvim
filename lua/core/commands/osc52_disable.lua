local clipboard = require "core.commands.clipboard"

vim.api.nvim_create_user_command("Osc52Disable", function()
	vim.g.clipboard = false
	local termfeatures = vim.g.termfeatures or {}
	termfeatures.osc52 = false
	vim.g.termfeatures = termfeatures
	clipboard.reload_provider()
	vim.notify("OSC 52 clipboard disabled for this session", vim.log.levels.INFO, { title = "Clipboard" })
end, { desc = "Disable OSC 52 clipboard queries for this session" })
