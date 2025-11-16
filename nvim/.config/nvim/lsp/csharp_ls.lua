return {
	cmd = { vim.fn.getenv("HOME") .. "/.dotnet/tools/csharp-ls" },
	-- root_markers = { "*.sln", "*.slnx" },
	filetypes = { "cs" },
	-- root_markers = function(name)
	-- 	return name:match("%.csproj$")
	-- end,
	root_dir = function(fname, callback)
		local root = vim.fs.root(fname, function(name, path)
			return name:match("%.csproj$") ~= nil
		end)
		callback(root)
	end,
	init_options = {
		AutomaticWorkspaceInit = true,
	},
}
