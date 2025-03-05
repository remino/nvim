-- local highlight = {
-- 	"CursorColumn",
-- 	"Whitespace",
-- }
-- require("ibl").setup {
-- 	indent = { highlight = highlight, char = "" },
-- 	whitespace = {
-- 		highlight = highlight,
-- 		remove_blankline_trail = false,
-- 	},
-- 	scope = { enabled = false },
-- }

function IblDisable()
	require("ibl").setup_buffer(0, {
		enabled = false,
	})
end

function IblEnable()
	require("ibl").setup_buffer(0, {
		enabled = true,
	})
end

function IblToggle()
	require("ibl").setup_buffer(0, {
		enabled = not require("ibl.config").get_config(0).enabled,
	})
end

vim.api.nvim_create_user_command("IblDisable", IblDisable, {})
vim.api.nvim_create_user_command("IblEnable", IblEnable, {})
vim.api.nvim_create_user_command("IblToggle", IblToggle, {})

vim.api.nvim_set_keymap(
	"n",
	"<leader>ti",
	"<Cmd>IblToggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle visual indentation" }
)

local highlight = {
	"RainbowCyan",
	"RainbowPink",
	"RainbowMagenta",
	"RainbowLightCyan",
	"RainbowDeepPink",
	"RainbowVividMagenta",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#00FFFF" })
	vim.api.nvim_set_hl(0, "RainbowPink", { fg = "#FF69B4" })
	vim.api.nvim_set_hl(0, "RainbowMagenta", { fg = "#FF00FF" })
	vim.api.nvim_set_hl(0, "RainbowLightCyan", { fg = "#E0FFFF" })
	vim.api.nvim_set_hl(0, "RainbowDeepPink", { fg = "#FF1493" })
	vim.api.nvim_set_hl(0, "RainbowVividMagenta", { fg = "#FF2B2B" })
	vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#FFD700" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }

require("ibl").setup {
	indent = { highlight = highlight },
	scope = { enabled = true, highlight = "CurrentScope" },
}
