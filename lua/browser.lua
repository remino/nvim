local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

vim.g.scraps_dir = vim.fn.expand((os.getenv("XDG_DATA_HOME") or "~/.local/share") .. "/scraps")

local function browse(directory)
	require("telescope.builtin").find_files {
		prompt_title = directory,
		cwd = directory,
		previewer = true,
		attach_mappings = function(_, map)
			map("i", "<C-p>", function(prompt_bufnr)
				local entry = action_state.get_selected_entry()
				local file_path = entry.path
				actions.close(prompt_bufnr)
				vim.api.nvim_command("read " .. file_path)
			end)
			return true
		end,
	}
end

vim.api.nvim_create_user_command("Browse", function(opts)
	browse(opts[1] or vim.fn.expand "%:p:h")
end, {})

vim.api.nvim_create_user_command("Scraps", function()
	browse(vim.g.scraps_dir or vim.fn.expand "%:p:h")
end, {})
