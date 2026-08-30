local commands = {
	"file_path",
	"termino_comment",
	"ai_health",
	"copilot_toggle",
	"copilot_status",
	"eslint_status",
	"lsp_buffer_status",
	"osc52_disable",
	"osc52_enable",
	"osc52_toggle",
}

for _, command in ipairs(commands) do
	require("core.commands." .. command)
end
