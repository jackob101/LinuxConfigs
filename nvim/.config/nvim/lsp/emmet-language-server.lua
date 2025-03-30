return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/emmet-language-server", "--stdio" },
	filetypes = { "html", "templ" },
	root_markers = { "index.html", ".git", "go.mod" },
}
