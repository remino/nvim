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
	{
		"samueljoli/hurl.nvim",
		lazy = false,
		config = function()
			require("hurl").setup {
				comment = "#ebc021", -- default => Comment
				method = "#fffc58", -- default => Statement
				url = "#fffc58", -- default => Underlined
				version = "#032ea7", -- default => Statement
				status = "#032ea7", -- default => Number
				section = "#032ea7", -- default => Statement
				operators = "#c592ff", -- default => Operator
				string = "#032ea7", -- default => String
				query = "#d57bff", -- default => Identifier
				filter = "#032ea7", -- default => Operator
				predicate = "#032ea7", -- default => Operator
				template = "#032ea7", -- default => Identifier
				escapeQuote = "#032ea7", -- default => SpecialChar
				escapeNumberSign = "#032ea7", -- default => SpecialChar
			}
		end,
	},
	{
		"olrtg/nvim-emmet",
		lazy = false,
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>mt", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
	{
		"svampkorg/moody.nvim",
		event = { "ModeChanged", "BufWinEnter", "WinEnter" },
		dependencies = {
			-- or whatever "colorscheme" you use to setup your HL groups :)
			-- Colours can also be set within setup, in which case this is redundant.
			"catppuccin/nvim",
			-- for seeing Moody's take on folds
			"kevinhwang91/nvim-ufo",
		},
	},
	{
		"slim-template/vim-slim",
		lazy = false,
	},
}
