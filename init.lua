vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.colorcolumn = "80,120"

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},

	{ import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
	require "mappings"
end)

if vim.loop.fs_stat(vim.fn.stdpath "config" .. "/lua/local.lua") then
	require "local"
end

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		if vim.fn.argc() == 0 and vim.fn.line2byte "$" == -1 then
			vim.cmd "Nvdash"
		end
	end,
})

vim.api.nvim_create_user_command("FilePath", function()
	print(vim.fn.expand "%:p")
end, {})
