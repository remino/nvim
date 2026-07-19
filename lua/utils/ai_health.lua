local M = {}

local function scratch(lines)
	local buf = vim.api.nvim_create_buf(false, true)

	vim.cmd("botright new")
	vim.api.nvim_win_set_buf(0, buf)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].modifiable = false
	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })

	vim.api.nvim_win_set_height(0, math.min(#lines + 2, 20))
end

function M.show()
	local lines = {
		"# AI Health",
		"",
		"- backend: `copilot`",
		"",
		"## Copilot",
		"- Run `:Copilot status` for auth and attachment state.",
		"- Run `:checkhealth copilot` for provider diagnostics.",
	}

	scratch(lines)
end

return M
