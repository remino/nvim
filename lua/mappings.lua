require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local function code_actions_without_disabled()
	vim.lsp.buf.code_action {
		filter = function(action)
			return action.disabled == nil
		end,
	}
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tt", ":Telescope<CR>", { desc = "Open Telescope" })
map("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Toggle Tree" })
map("i", "<C-b>", "<esc>:NvimTreeToggle<CR>", { desc = "Toggle Tree" })
map({ "n", "v" }, "<leader>ca", code_actions_without_disabled, { desc = "Code actions" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
