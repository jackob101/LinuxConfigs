return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss" },
	root_markers = { "index.html", ".git", "go.mod" },
}
