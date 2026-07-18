local ai_provider = require("utils.ai_provider")

local M = {}

local function scratch(lines)
	local buf = vim.api.nvim_create_buf(false, true)

	vim.cmd("botright new")
	vim.api.nvim_win_set_buf(0, buf)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].modifiable = false
	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })

	vim.api.nvim_win_set_height(0, math.min(#lines + 2, 20))
end

local function http_probe(url)
	if not url or url == "" then
		return {
			ok = false,
			message = "no URL configured",
		}
	end

	if vim.fn.executable("curl") ~= 1 then
		return {
			ok = false,
			message = "curl not found",
		}
	end

	local result = vim.system({
		"curl",
		"-sS",
		"-o",
		"/dev/null",
		"-w",
		"%{http_code}",
		url,
	}, { text = true }):wait()

	local code = vim.trim(result.stdout or "")

	if result.code == 0 and code:match("^2%d%d$") then
		return {
			ok = true,
			message = "HTTP " .. code,
		}
	end

	local stderr = vim.trim(result.stderr or "")
	if stderr == "" then
		stderr = "HTTP " .. (code ~= "" and code or "error")
	end

	return {
		ok = false,
		message = stderr,
	}
end

local function derive_host(url)
	if type(url) ~= "string" or url == "" then
		return nil
	end

	return url:match("^(https?://[^/]+)")
end

local function live_avante_config()
	local ok_config, avante_config = pcall(require, "avante.config")
	if not ok_config or type(avante_config) ~= "table" then
		return nil, "Avante not loaded"
	end

	local provider = avante_config.provider
	if type(provider) ~= "string" or provider == "" then
		return nil, "Avante provider unavailable"
	end

	local ok_provider, providers = pcall(require, "avante.providers")
	if not ok_provider then
		return nil, "Avante providers unavailable"
	end

	local ok_current, current = pcall(providers.get_config, provider)
	if not ok_current or type(current) ~= "table" then
		return nil, "Avante live provider config unavailable"
	end

	return {
		provider = provider,
		auto_suggestions_provider = avante_config.auto_suggestions_provider,
		endpoint = current.endpoint,
		model = current.model,
	}, nil
end

local function live_minuet_config()
	local ok_minuet, minuet = pcall(require, "minuet")
	if not ok_minuet or type(minuet) ~= "table" or type(minuet.config) ~= "table" then
		return nil, "Minuet not loaded"
	end

	local provider = minuet.config.provider
	local provider_options = (minuet.config.provider_options or {})[provider] or {}

	return {
		provider = provider,
		endpoint = provider_options.end_point,
		model = provider_options.model,
		name = provider_options.name,
	}, nil
end

local function append_ollama(lines)
	local avante, avante_err = live_avante_config()
	local minuet, minuet_err = live_minuet_config()

	local host = derive_host(avante and avante.endpoint) or derive_host(minuet and minuet.endpoint)
	local probe = http_probe(host and (host .. "/api/tags") or nil)

	vim.list_extend(lines, {
		"",
		"## Ollama",
		"- host: `" .. (host or "unavailable") .. "`",
		"- reachability: " .. (probe.ok and "`ok`" or "`failed`") .. " (" .. probe.message .. ")",
		"",
		"## Avante",
		"- status: `" .. (avante_err or "loaded") .. "`",
		"- provider: `" .. ((avante and avante.provider) or "unavailable") .. "`",
		"- auto suggestions: `" .. ((avante and avante.auto_suggestions_provider) or "unavailable") .. "`",
		"- endpoint: `" .. ((avante and avante.endpoint) or "unavailable") .. "`",
		"- model: `" .. ((avante and avante.model) or "unavailable") .. "`",
		"",
		"## Minuet",
		"- status: `" .. (minuet_err or "loaded") .. "`",
		"- provider: `" .. ((minuet and minuet.provider) or "unavailable") .. "`",
		"- backend name: `" .. ((minuet and minuet.name) or "unavailable") .. "`",
		"- endpoint: `" .. ((minuet and minuet.endpoint) or "unavailable") .. "`",
		"- model: `" .. ((minuet and minuet.model) or "unavailable") .. "`",
		"",
		"## Next checks",
		"- Run `:checkhealth avante` for Avante dependencies.",
		"- If Minuet says `not loaded`, open a code buffer and trigger `nvim-cmp`, then run `:AiHealth` again.",
	})
end

function M.show()
	local backend = ai_provider.get().backend
	local lines = {
		"# AI Health",
		"",
		"- backend: `" .. backend .. "`",
	}

	if backend == "ollama" then
		append_ollama(lines)
	elseif backend == "copilot" then
		vim.list_extend(lines, {
			"",
			"## Copilot",
			"- Run `:Copilot status` for auth and attachment state.",
			"- Run `:checkhealth copilot` for provider diagnostics.",
			"- Run `:checkhealth avante` for Avante dependencies.",
		})
	else
		vim.list_extend(lines, {
			"",
			"- No AI backend is enabled. Set `lua/local/ai.lua` or `NVIM_AI_BACKEND`.",
		})
	end

	scratch(lines)
end

return M
