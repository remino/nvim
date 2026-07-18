local ai_provider = require("utils.ai_provider")
local backend = ai_provider.get().backend

local avante_defaults = {
	enabled = false,
	build = "make",
	opts = {
		provider = "copilot",
		auto_suggestions_provider = "copilot",
		windows = {
			edit = {
				border = "rounded",
			},
			ask = {
				floating = true,
				border = "rounded",
			},
		},
		mappings = {
			suggestion = {
				accept = "<C-y>",
			},
		},
	},
}

if backend == "copilot" then
	avante_defaults.enabled = true
elseif backend == "ollama" then
	avante_defaults.enabled = true
	avante_defaults.opts = vim.tbl_deep_extend("force", avante_defaults.opts, {
		provider = "ollama",
		auto_suggestions_provider = "ollama",
		providers = {
			ollama = {
				endpoint = vim.env.OLLAMA_HOST or "http://127.0.0.1:11434",
				model = vim.env.AVANTE_OLLAMA_MODEL or "",
			},
		},
	})
end

local avante_config = require("utils.local_config").merge(avante_defaults, "local.avante")

return {
	{
		"yetone/avante.nvim",
		enabled = avante_config.enabled,
		event = "VeryLazy",
		version = false,
		opts = avante_config.opts,
		build = avante_config.build,
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
