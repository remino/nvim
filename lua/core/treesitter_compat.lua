local ts = vim.treesitter

local function unwrap_node(node)
	if type(node) == "table" and node[1] and type(node[1]) == "userdata" then
		return node[1]
	end

	return node
end

-- Neovim 0.12 can pass a list of nodes to older query directives.
-- Some plugins still expect a single TSNode, so unwrap the first match.
if ts.get_node_text then
	local old_get_node_text = ts.get_node_text
	ts.get_node_text = function(node, source, opts)
		return old_get_node_text(unwrap_node(node), source, opts)
	end
end

if ts.get_range then
	local old_get_range = ts.get_range
	ts.get_range = function(node, source, metadata)
		return old_get_range(unwrap_node(node), source, metadata)
	end
end
