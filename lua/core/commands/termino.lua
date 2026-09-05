local figlet = require "core.commands.figlet"
local fonts = require "utils.figlet_fonts"

local M = {}

function M.font(name)
	local directories = {
		vim.g.termino_font_dir,
		vim.g.termino_dir and vim.g.termino_dir .. "/share/figlet",
		vim.env.TERMINO_FIGLET_DIR,
		vim.env.TERMINO_DIR and vim.env.TERMINO_DIR .. "/share/figlet",
	}

	if vim.fn.executable "brew" == 1 then
		local prefix = vim.fn.systemlist { "brew", "--prefix", "termino" }[1]
		if vim.v.shell_error == 0 then
			directories[#directories + 1] = prefix .. "/share/figlet"
		end
	end

	return fonts.resolve(name, directories)
end

function M.replace(opts, font, title)
	return figlet.replace(opts, M.font(font), 1, title)
end

function M.create(command, font, desc)
	vim.api.nvim_create_user_command(command, function(opts)
		M.replace(opts, font, command)
	end, {
		desc = desc,
		nargs = "*",
		range = true,
	})
end

M.create(
	"Termino",
	"termino",
	"Replace text with a Termino Figlet heading"
)

return M
