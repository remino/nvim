local trim_left = require "core.commands.trim_left"
local trim_right = require "core.commands.trim_right"

vim.api.nvim_create_user_command("Trim", function(opts)
	trim_left.range(opts.line1, opts.line2)
	trim_right.range(opts.line1, opts.line2)
end, {
	desc = "Remove leading and trailing whitespace from lines",
	range = true,
})
