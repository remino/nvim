return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo", "Format", "FormatDisable", "FormatEnable" },
		keys = {
			{
				"<leader>cd",
				"<Cmd>FormatDisable<CR>",
				mode = "",
				desc = "Disable autoformat on save",
			},
			{
				"<leader>ce",
				"<Cmd>FormatEnable<CR>",
				mode = "",
				desc = "Enable autoformat on save",
			},
			{
				"<leader>cf",
				"<Cmd>Format<CR>",
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = function()
			return require "configs.conform"
		end,
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "configs.lspconfig"
		end,
		lazy = false,
	},

	{
		"github/copilot.vim",
		lazy = false,
	},

	{
		"brenton-leighton/multiple-cursors.nvim",
		lazy = false,
		version = "*", -- Use the latest tagged version
		opts = {}, -- This causes the plugin setup function to be called
		keys = {
			-- <C-j> & <C-k> just won't work here. Don't know why. Added them to mappings.lua instead.
			{
				"<M-j>",
				"<Cmd>MultipleCursorsAddDown<CR>",
				mode = { "n", "x" },
				desc = "Add cursor and move down",
			},
			{
				"<M-k>",
				"<Cmd>MultipleCursorsAddUp<CR>",
				mode = { "n", "x" },
				desc = "Add cursor and move up",
			},

			{
				"<M-Up>",
				"<Cmd>MultipleCursorsAddUp<CR>",
				mode = { "n", "i", "x" },
				desc = "Add cursor and move up",
			},
			{
				"<M-Down>",
				"<Cmd>MultipleCursorsAddDown<CR>",
				mode = { "n", "i", "x" },
				desc = "Add cursor and move down",
			},

			{
				"<C-LeftMouse>",
				"<Cmd>MultipleCursorsMouseAddDelete<CR>",
				mode = { "n", "i" },
				desc = "Add or remove cursor",
			},

			{
				"<Leader>a",
				"<Cmd>MultipleCursorsAddMatches<CR>",
				mode = { "n", "x" },
				desc = "Add cursors to cword",
			},
			{
				"<Leader>A",
				"<Cmd>MultipleCursorsAddMatchesV<CR>",
				mode = { "n", "x" },
				desc = "Add cursors to cword in previous area",
			},

			{
				"<Leader>d",
				"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
				mode = { "n", "x" },
				desc = "Add cursor and jump to next cword",
			},
			{ "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

			{ "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
		},
	},

	{
		"numToStr/Comment.nvim",
		lazy = false,
		opts = {
			-- add any options here
		},
	},

	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"vim", "lua", "vimdoc",
	--      "html", "css"
	-- 		},
	-- 	},
	-- },
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			-- Setup orgmode
			require("orgmode").setup {
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/refile.org",
			}

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
			--   ensure_installed = 'all',
			--   ignore_install = { 'org' },
			-- })
		end,
	},
	{
		"hedyhli/markdown-toc.nvim",
		ft = "markdown", -- Lazy load on markdown filetype
		cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
		opts = {
			-- Your configuration here (optional)
		},
	},
}
