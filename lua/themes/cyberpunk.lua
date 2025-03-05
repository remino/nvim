-- Credits to original https://github.com/EdenEast/nightfox.nvim

local M = {}

M.base_30 = {
	white = "#d5ccff",
	darker_black = "#090510",
	black = "#12081a", -- Base background
	black2 = "#180d26",
	one_bg = "#1f1033", -- Real BG (deep magenta-purple)
	one_bg2 = "#2a1445",
	one_bg3 = "#341a58",
	grey = "#402366",
	grey_fg = "#4b2c78",
	grey_fg2 = "#55358a",
	light_grey = "#5f3e9c",
	red = "#ff1e5a",
	baby_pink = "#ff62a5",
	pink = "#ff3ca6",
	line = "#240c3d", -- Line colors like vertsplit
	green = "#72ffcb",
	vibrant_green = "#5affd6",
	blue = "#6b92ff",
	nord_blue = "#709aff",
	yellow = "#ffd36f",
	sun = "#ffdb80",
	purple = "#b870ff",
	dark_purple = "#924dff",
	teal = "#5affff",
	orange = "#ff7e67",
	cyan = "#60e8ff",
	statusline_bg = "#180d26",
	lightbg = "#2a1445",
	pmenu_bg = "#6b92ff",
	folder_bg = "#6b92ff",
}

M.base_16 = {
	base00 = "#12081a",
	base01 = "#1f1033",
	base02 = "#2a1445",
	base03 = "#341a58",
	base04 = "#402366",
	base05 = "#d5ccff",
	base06 = "#e0d9ff",
	base07 = "#ebe6ff",
	base08 = "#ff3ca6",
	base09 = "#ff7e67",
	base0A = "#ffd36f",
	base0B = "#72ffcb",
	base0C = "#5affff",
	base0D = "#709aff",
	base0E = "#924dff",
	base0F = "#d5ccff",
}

M.polish_hl = {
	treesitter = {
		["@variable.member.key"] = { fg = M.base_16.base05 },
		["@operator"] = { fg = M.base_30.dark_purple },
		["@keyword"] = { fg = M.base_30.pink },
		["@variable.parameter"] = { fg = M.base_30.cyan },
	},
}

M.type = "dark"

M = require("base46").override_theme(M, "cyberpunk")

return M
