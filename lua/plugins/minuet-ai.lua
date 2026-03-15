local function get_minuet_config()
	local config = {
		provider = vim.env.MINUET_PROVIDER or "openai_fim_compatible",
		n_completions = 1,
		context_window = 512,
		request_timeout = 15,
		virtualtext = {
			auto_trigger_ft = { "*" },
			keymap = {
				accept = "<A-A>",
				accept_line = "<A-a>",
				accept_n_lines = "<A-z>",
				prev = "<A-j>",
				next = "<A-k>",
				dismiss = "<A-e>",
			},
			show_on_completion_menu = true,
		},
		provider_options = {
			openai_fim_compatible = {
				api_key = vim.env.MINUET_API_KEY or "TERM",
				name = "Ollama",
				end_point = vim.env.MINUET_OLLAMA_FIM_ENDPOINT or "",
				model = vim.env.MINUET_OLLAMA_FIM_MODEL or "",
				optional = {
					max_tokens = 56,
					top_p = 0.9,
				},
			},
			openai_compatible = {
				api_key = vim.env.MINUET_API_KEY or "TERM",
				name = "Ollama",
				end_point = vim.env.MINUET_OLLAMA_CHAT_ENDPOINT or "",
				model = vim.env.MINUET_OLLAMA_CHAT_MODEL or "",
				optional = {
					max_tokens = 56,
					top_p = 0.9,
					reasoning_effort = "none",
				},
			},
		},
	}

	local local_config = type(vim.g.local_minuet_config) == "table" and vim.g.local_minuet_config or {}
	return vim.tbl_deep_extend("force", config, local_config)
end

return {
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"milanglacier/minuet-ai.nvim",
		},
		opts = function(_, opts)
			local minuet_config = get_minuet_config()
			local provider_config = minuet_config.provider_options[minuet_config.provider] or {}

			if provider_config.end_point ~= "" and provider_config.model ~= "" then
				require("minuet").setup(minuet_config)
			end

			opts.performance = vim.tbl_deep_extend("force", opts.performance or {}, {
				fetching_timeout = 15000,
			})

			return opts
		end,
	},
}
