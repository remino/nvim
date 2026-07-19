vim.api.nvim_create_user_command("FilePath", function()
	print(vim.fn.expand "%:p")
end, {})

vim.api.nvim_create_user_command("AiHealth", function()
	require("utils.ai_health").show()
end, {})

local function copilot_effective_enabled()
	local ok, enabled = pcall(vim.fn["copilot#Enabled"])
	return ok and enabled == 1
end

local function notify_copilot_state()
	local state = copilot_effective_enabled() and "enabled" or "disabled"
	vim.notify("Copilot " .. state, vim.log.levels.INFO, { title = "Copilot" })
end

vim.api.nvim_create_user_command("CopilotToggle", function()
	if copilot_effective_enabled() then
		vim.cmd "Copilot disable"
	else
		vim.cmd "Copilot enable"
	end

	notify_copilot_state()
end, {})

vim.api.nvim_create_user_command("CopilotStatus", function()
	notify_copilot_state()
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
