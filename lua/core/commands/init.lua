local commands = {
	"file_path",
	"figlet",
	"trim_left",
	"trim_right",
	"trim",
	"termino",
	"termino_mono",
	"termino_raster",
	"termino_tabular",
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
