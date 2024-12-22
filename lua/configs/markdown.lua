vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.colorcolumn = ""
		vim.opt_local.columns = 86
		vim.opt_local.linebreak = true
		vim.opt_local.numberwidth = 4
		vim.opt_local.wrap = true
	end,
})
