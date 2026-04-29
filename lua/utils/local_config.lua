local M = {}

function M.safe_require(module)
	local ok, value = pcall(require, module)
	if ok then
		return value
	end

	local message = tostring(value)
	local missing_module = ("module '%s' not found"):format(module)
	if not message:find(missing_module, 1, true) then
		error(value)
	end
end

function M.run(module, ...)
	local value = M.safe_require(module)

	if type(value) == "function" then
		return value(...)
	end

	return value
end

function M.merge(defaults, module)
	local override = M.run(module, defaults)

	if type(override) ~= "table" then
		return defaults
	end

	return vim.tbl_deep_extend("force", defaults, override)
end

function M.extend(defaults, module)
	local override = M.run(module, defaults)

	if type(override) ~= "table" then
		return defaults
	end

	vim.list_extend(defaults, override)
	return defaults
end

return M
