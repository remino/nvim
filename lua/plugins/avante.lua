local avante_config = require("utils.local_config").merge({
	enabled = false,
	build = "make",
	opts = {
		provider = "copilot",
		auto_suggestions_provider = "copilot",
		mappings = {
			suggestion = {
				accept = "<C-y>",
			},
		},
	},
}, "local.avante")

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
