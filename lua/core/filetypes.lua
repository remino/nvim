vim.filetype.add {
	extension = {
		bats = "bats",
	},
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		local first = vim.fn.getline(1)
		if first:match "^#!.*[/ ]bash" then
			vim.bo.filetype = "bash"
		end
	end,
})
