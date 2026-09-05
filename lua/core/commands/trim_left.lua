local M = {}

function M.range(line1, line2)
	local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
	for index, line in ipairs(lines) do
		lines[index] = line:gsub("^%s+", "")
	end

	vim.api.nvim_buf_set_lines(0, line1 - 1, line2, false, lines)
end

vim.api.nvim_create_user_command("TrimLeft", function(opts)
	M.range(opts.line1, opts.line2)
end, {
	desc = "Remove leading whitespace from lines",
	range = true,
})

return M
