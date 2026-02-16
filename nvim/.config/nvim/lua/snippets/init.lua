local luasnip = require("luasnip")

local snippets = {
	"snippets.zig",
	"snippets.csharp",
	"snippets.lua",
	"snippets.go",
}
local M = {}

local function load_project_snippets()
	-- Construct the path to the project-specific snippet file
	local project_snippets_path = vim.fn.getcwd() .. "/.nvim/snippets.lua"

	-- Check if the file exists and load it
	if vim.fn.filereadable(project_snippets_path) == 1 then
		dofile(project_snippets_path)
		print("Loaded project snippets from: " .. project_snippets_path)
	else
		print("No project snippets found.")
	end
end

function M.reload_snippets()
	luasnip.cleanup()
	for _, value in pairs(snippets) do
		package.loaded[value] = nil
		require(value).load()
	end
	load_project_snippets()
	require("luasnip.loaders.from_vscode").lazy_load()
end

return M
