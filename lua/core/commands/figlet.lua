local M = {}
local fonts = require "utils.figlet_fonts"

local function heading_from(opts, start_index)
	local heading = table.concat(vim.list_slice(opts.fargs, start_index), " ")
	if heading == "" then
		heading = table.concat(vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false), " ")
	end

	return heading
end

function M.render(opts, font, start_index, title)
	local heading = heading_from(opts, start_index)
	if heading:match "^%s*$" then
		vim.notify("Provide a heading or select text to format", vim.log.levels.WARN, { title = title })
		return nil
	end

	local output = vim.fn.systemlist({ "figlet", "-f", font, "-w", "120" }, heading)
	if vim.v.shell_error ~= 0 then
		vim.notify(table.concat(output, "\n"), vim.log.levels.ERROR, { title = title })
		return nil
	end

	return output
end

function M.replace(opts, font, start_index, title)
	local output = M.render(opts, font, start_index, title)
	if not output then
		return nil
	end

	vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, output)
	return #output
end

vim.api.nvim_create_user_command("Figlet", function(opts)
	M.replace(opts, fonts.resolve(opts.fargs[1]), 2, "Figlet")
end, {
	desc = "Replace text with a Figlet heading using {font-or-path}",
	nargs = "+",
	range = true,
})

return M
