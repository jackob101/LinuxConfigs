return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ", "razor" },
	root_markers = { "index.html", ".git", "go.mod" },
	settings = {
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
}
