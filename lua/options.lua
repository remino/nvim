require "nvchad.options"

-- add yours here!

if vim.fn.has "macunix" == 1 and vim.fn.executable "pbcopy" == 1 and vim.fn.executable "pbpaste" == 1 then
	local function normalize_newlines(text)
		return text:gsub("\r\n", "\n"):gsub("\r", "\n")
	end

	local function copy(lines, regtype)
		local text = table.concat(lines, "\n")
		if regtype == "V" then
			text = text .. "\n"
		end

		vim.fn.system("pbcopy", text)
	end

	local function paste()
		local text = normalize_newlines(vim.fn.system "pbpaste")
		local regtype = "v"

		if text:sub(-1) == "\n" then
			regtype = "V"
			text = text:sub(1, -2)
		end

		return { vim.split(text, "\n", { plain = true }), regtype }
	end

	vim.g.clipboard = {
		name = "pbcopy-normalized",
		copy = {
			["+"] = copy,
			["*"] = copy,
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
		cache_enabled = 1,
	}
end

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.cursorcolumn = true
o.scrolloff = 8
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
