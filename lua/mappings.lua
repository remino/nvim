require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tt", ":Telescope<CR>", { desc = "Open Telescope" })
map("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Toggle Tree" })
map("i", "<C-b>", "<esc>:NvimTreeToggle<CR>", { desc = "Toggle Tree" })
map("n", "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down" })
map("x", "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down" })
map("n", "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up" })
map("x", "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
