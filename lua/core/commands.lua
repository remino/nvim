vim.api.nvim_create_user_command("FilePath", function()
	print(vim.fn.expand "%:p")
end, {})

vim.api.nvim_create_user_command("AiHealth", function()
	require("utils.ai_health").show()
end, {})

vim.api.nvim_create_user_command("EslintStatus", function()
	local mason_cmd = vim.fn.stdpath "data" .. "/mason/bin/vscode-eslint-language-server"
	local path_cmd = vim.fn.exepath "vscode-eslint-language-server"
	local resolved_cmd = vim.fn.exepath(mason_cmd)
	local attached_clients = vim.lsp.get_clients { name = "eslint", bufnr = 0 }

	if resolved_cmd == "" then
		resolved_cmd = path_cmd
	end

	local lines = {
		("mason binary: %s"):format(vim.fn.executable(mason_cmd) == 1 and "yes" or "no"),
		("path binary: %s"):format(path_cmd ~= "" and "yes" or "no"),
		("resolved cmd: %s"):format(resolved_cmd ~= "" and resolved_cmd or "not found"),
		("attached: %s"):format(#attached_clients > 0 and "yes" or "no"),
	}

	if #attached_clients > 0 then
		lines[#lines + 1] = ("client id: %s"):format(attached_clients[1].id)
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "EslintStatus" })
end, {})
