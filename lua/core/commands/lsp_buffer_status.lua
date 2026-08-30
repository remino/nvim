vim.api.nvim_create_user_command("LspBufferStatus", function()
	local clients = vim.lsp.get_clients { bufnr = 0 }
	local lines = {}

	if #clients == 0 then
		lines[1] = "no attached clients"
	else
		for _, client in ipairs(clients) do
			lines[#lines + 1] = ("%s (id=%s)"):format(client.name, client.id)
		end
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "LspBufferStatus" })
end, {})
