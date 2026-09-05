local function modeline()
	local options = {
		"ts=" .. vim.bo.tabstop,
		"sw=" .. vim.bo.shiftwidth,
		"sts=" .. vim.bo.softtabstop,
		vim.bo.expandtab and "et" or "noet",
	}

	return "vim: set " .. table.concat(options, " ") .. " :"
end

local function comment(line)
	local commentstring = vim.bo.commentstring
	if commentstring == "" or not commentstring:find("%%s") then
		return line
	end

	return (commentstring:gsub("%%s", line))
end

vim.api.nvim_create_user_command("Modeline", function()
	local line = modeline()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for _, existing in ipairs(lines) do
		if existing:find("vim:%s*set", 1) then
			vim.notify("A Vim modeline already exists in this buffer", vim.log.levels.WARN, { title = "Modeline" })
			return
		end
	end

	vim.api.nvim_buf_set_lines(0, -1, -1, false, { comment(line) })
end, {
	desc = "Append a comment-aware Vim modeline using current indentation settings",
})
