local function set_indent(expandtab)
	vim.bo.tabstop = 2
	vim.bo.shiftwidth = 2
	vim.bo.expandtab = expandtab
end

vim.api.nvim_create_user_command("Indent2Noet", function()
	set_indent(false)
end, {
	desc = "Set tabstop and shiftwidth to 2; use tabs for indentation",
})

vim.api.nvim_create_user_command("Indent2Et", function()
	set_indent(true)
end, {
	desc = "Set tabstop and shiftwidth to 2; use spaces for indentation",
})
