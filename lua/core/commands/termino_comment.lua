vim.api.nvim_create_user_command("TerminoComment", function(opts)
	local heading = opts.args
	if heading == "" then
		heading = table.concat(vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false), " ")
	end

	if heading:match "^%s*$" then
		vim.notify("Provide a heading or select text to format", vim.log.levels.WARN, { title = "TerminoComment" })
		return
	end

	local output = vim.fn.systemlist({
		"figlet",
		"-f",
		"/opt/homebrew/opt/termino/share/figlet/termino-raster.flf",
		"-w",
		"120",
	}, heading)

	if vim.v.shell_error ~= 0 then
		vim.notify(table.concat(output, "\n"), vim.log.levels.ERROR, { title = "TerminoComment" })
		return
	end

	local formatted = {}
	for _, line in ipairs(output) do
		if not line:match "^%s*$" then
			formatted[#formatted + 1] = "# " .. line:gsub("%s+$", "")
		end
	end

	vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, formatted)
end, {
	desc = "Replace text with a Termino Figlet heading",
	nargs = "*",
	range = true,
})
