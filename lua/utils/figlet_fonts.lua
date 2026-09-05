local M = {}

local function add(directory, directories)
	if directory and directory ~= "" then
		directories[#directories + 1] = directory
	end
end

local function add_many(values, directories)
	if type(values) == "table" then
		for _, directory in ipairs(values) do
			add(directory, directories)
		end
	else
		add(values, directories)
	end
end

function M.directories(extra)
	local directories = {}
	add_many(vim.g.figlet_font_dirs, directories)
	add(vim.env.FIGLET_FONTDIR, directories)

	if vim.fn.executable "figlet" == 1 then
		local font_directory = vim.fn.systemlist { "figlet", "-I2" }[1]
		if vim.v.shell_error == 0 then
			add(font_directory, directories)
		end
	end

	add_many(extra, directories)
	return directories
end

function M.resolve(font, extra_directories)
	if vim.uv.fs_stat(font) then
		return font
	end

	local filename = font:match "%.flf$" and font or font .. ".flf"
	for _, directory in ipairs(M.directories(extra_directories)) do
		local path = directory .. "/" .. filename
		if vim.uv.fs_stat(path) then
			return path
		end
	end

	-- Preserve Figlet's own lookup behavior and error message as a final fallback.
	return font
end

return M
