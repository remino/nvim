dofile(vim.g.base46_cache .. "telescope")

local function open_all_selected_files(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local entries = picker:get_multi_selection()
	require("telescope.actions").close(prompt_bufnr)
	for _, entry in ipairs(entries) do
		vim.cmd("edit " .. entry.value)
	end
end

local config = require "nvchad.configs.telescope"

config.pickers = {
	find_files = {
		mappings = {
			i = { ["<M-CR>"] = open_all_selected_files },
		},
	},
}

return config
