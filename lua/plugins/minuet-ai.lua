local function get_minuet_config()
	local ai_provider = require("utils.ai_provider")
	local config = {
		enable_predicates = {
			function()
				return ai_provider.is("ollama")
			end,
		},
		provider = vim.env.MINUET_PROVIDER or "openai_fim_compatible",
		n_completions = 1,
		context_window = 512,
		request_timeout = 15,
		virtualtext = {
			auto_trigger_ft = { "*" },
			auto_trigger_ignore_ft = {
				"TelescopePrompt",
				"help",
				"lazy",
				"mason",
				"man",
				"Nvdash",
				"qf",
			},
			keymap = {
				accept = "<C-y>",
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

	config = require("utils.local_config").merge(config, "local.minuet")

	if type(vim.g.local_minuet_config) == "table" then
		config = vim.tbl_deep_extend("force", config, vim.g.local_minuet_config)
	end

	return config
end

local function predicates_enabled(predicates)
	for _, predicate in ipairs(predicates or {}) do
		if type(predicate) == "function" and not predicate() then
			return false
		end
	end

	return true
end

local function ai_completion_allowed(bufnr)
	bufnr = bufnr or 0

	local blocked_buftypes = {
		nofile = true,
		prompt = true,
		quickfix = true,
		terminal = true,
	}

	if blocked_buftypes[vim.bo[bufnr].buftype] then
		return false
	end

	return not vim.tbl_contains({
		"TelescopePrompt",
		"help",
		"lazy",
		"mason",
		"man",
		"Nvdash",
		"qf",
	}, vim.bo[bufnr].filetype)
end

local function has_cmp_source(sources, name)
	for _, source in ipairs(sources or {}) do
		if source.name == name then
			return true
		end
	end

	return false
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
			local cmp = require("cmp")
			local minuet_config = get_minuet_config()
			local provider_config = minuet_config.provider_options[minuet_config.provider] or {}
			local enabled = predicates_enabled(minuet_config.enable_predicates)

			if enabled and provider_config.end_point ~= "" and provider_config.model ~= "" then
				require("minuet").setup(minuet_config)

				local group = vim.api.nvim_create_augroup("MinuetBufferGate", { clear = true })
				vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
					group = group,
					callback = function(args)
						if not ai_completion_allowed(args.buf) then
							vim.b[args.buf].minuet_virtual_text_auto_trigger = false
						end
					end,
				})

				opts.sources = opts.sources or {}
				if not has_cmp_source(opts.sources, "minuet") then
					table.insert(opts.sources, 1, { name = "minuet" })
				end

				opts.mapping = opts.mapping or {}
				opts.mapping["<C-y>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}
						return
					end

					local ok, virtualtext = pcall(require, "minuet.virtualtext")
					if ok and virtualtext.action.is_visible() then
						virtualtext.action.accept()
						return
					end

					fallback()
				end, { "i", "s" })
			end

			opts.performance = vim.tbl_deep_extend("force", opts.performance or {}, {
				fetching_timeout = 15000,
			})

			return opts
		end,
	},
}
