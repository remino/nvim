vim.api.nvim_create_user_command("FilePath", function()
	print(vim.fn.expand "%:p")
end, {})

vim.api.nvim_create_user_command("AiHealth", function()
	require("utils.ai_health").show()
end, {})
