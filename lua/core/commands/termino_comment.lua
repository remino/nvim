local termino = require "core.commands.termino"
local trim_right = require "core.commands.trim_right"

vim.api.nvim_create_user_command("TerminoComment", function(opts)
	local line_count = termino.replace(opts, "termino-raster", "TerminoComment")
	if not line_count then
		return
	end

	local line1 = opts.line1
	local line2 = line1 + line_count - 1
	trim_right.range(line1, line2)

	local ok, comment = pcall(require, "Comment.api")
	if ok then
		vim.api.nvim_win_set_cursor(0, { line1, 0 })
		comment.comment.linewise.count(line_count)
	elseif vim.bo.commentstring ~= "" then
		vim.cmd { cmd = "normal", args = { "gcc" }, range = { line1, line2 } }
	else
		vim.notify("Cannot comment: buffer has no commentstring", vim.log.levels.ERROR, { title = "TerminoComment" })
	end
end, {
	desc = "Replace text with a trimmed, commented Termino Raster heading",
	nargs = "*",
	range = true,
})
