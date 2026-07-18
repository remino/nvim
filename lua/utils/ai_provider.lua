local local_config = require("utils.local_config")

local M = {}

local function get_local_override()
	local override = local_config.run("local.ai")

	if type(override) ~= "table" then
		return {}
	end

	return override
end

function M.get()
	local config = {
		backend = vim.env.NVIM_AI_BACKEND or "none",
	}

	config = vim.tbl_deep_extend("force", config, get_local_override())

	return config
end

function M.is(backend)
	return M.get().backend == backend
end

return M
