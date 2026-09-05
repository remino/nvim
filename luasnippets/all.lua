local function modeline(expandtab)
	local line = "vim: set ts=2 sw=2 " .. (expandtab and "et" or "noet") .. " :"
	local commentstring = vim.bo.commentstring

	if commentstring == "" or not commentstring:find("%%s") then
		return line
	end

	return (commentstring:gsub("%%s", line))
end

return {
	s("mdl", {
		f(function()
			return modeline(false)
		end),
		i(0),
	}, { dscr = "Insert a comment-aware ts=2 sw=2 noet Vim modeline" }),
	s("mdlet", {
		f(function()
			return modeline(true)
		end),
		i(0),
	}, { dscr = "Insert a comment-aware ts=2 sw=2 et Vim modeline" }),
}
