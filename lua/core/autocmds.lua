vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		if vim.fn.argc() == 0 and vim.fn.line2byte "$" == -1 then
			vim.cmd "Nvdash"
		end
	end,
})
