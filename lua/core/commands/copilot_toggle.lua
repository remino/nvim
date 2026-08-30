local copilot = require "core.commands.copilot"

vim.api.nvim_create_user_command("CopilotToggle", function()
	if copilot.effective_enabled() then
		vim.cmd "Copilot disable"
	else
		vim.cmd "Copilot enable"
	end

	copilot.notify_state()
end, {})
