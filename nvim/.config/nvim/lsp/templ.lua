return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/templ", "lsp" },
	root_markers = { "go.mod", ".git" },
	filetypes = { "templ" },
	single_file_support = true,
	settings = {},
}
