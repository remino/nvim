local copilot = require "core.commands.copilot"

vim.api.nvim_create_user_command("CopilotStatus", function()
	copilot.notify_state()
end, {})
