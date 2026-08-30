vim.api.nvim_create_user_command("Osc52Toggle", function()
	if vim.g.clipboard == "osc52" then
		vim.cmd "Osc52Disable"
	else
		vim.cmd "Osc52Enable"
	end
end, { desc = "Toggle OSC 52 clipboard queries for this session" })
