local M = {}

function M.effective_enabled()
	local ok, enabled = pcall(vim.fn["copilot#Enabled"])
	return ok and enabled == 1
end

function M.notify_state()
	local state = M.effective_enabled() and "enabled" or "disabled"
	vim.notify("Copilot " .. state, vim.log.levels.INFO, { title = "Copilot" })
end

return M
