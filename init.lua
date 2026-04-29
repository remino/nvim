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

local local_config = require "utils.local_config"
local lazy_config = require "configs.lazy"

local plugins = {
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},

	{ import = "plugins" },
}

local_config.run "local"
local_config.run "local.before"
local_config.extend(plugins, "local.plugins")

-- load plugins
require("lazy").setup(plugins, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
local_config.run "local.options"

require "nvchad.autocmds"
require "core.filetypes"
require "core.autocmds"
require "core.commands"

vim.schedule(function()
	require "mappings"
	local_config.run "local.mappings"
	local_config.run "local.after"
end)
