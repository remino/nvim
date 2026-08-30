local M = {}

function M.reload_provider()
	if vim.g.loaded_clipboard_provider ~= nil then
		vim.g.loaded_clipboard_provider = nil
		vim.cmd "runtime autoload/provider/clipboard.vim"
	end
end

return M
