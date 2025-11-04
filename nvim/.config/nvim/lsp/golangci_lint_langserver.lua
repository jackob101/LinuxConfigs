return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/golangci-lint-langserver" },
	root_markers = { "go.mod", ".git" },
	filetypes = { "go" },
	single_file_support = true,
}
