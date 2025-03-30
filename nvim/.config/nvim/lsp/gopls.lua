return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" },
	root_markers = { "go.mod", ".git" },
	filetypes = { "go" },
	single_file_support = true,
	settings = {
		gopls = {
			["ui.inlayhint.hints"] = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
