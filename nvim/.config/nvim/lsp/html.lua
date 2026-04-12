return {
	cmd = { "vscode-html-languageserver", "--stdio" },
	filetypes = { "html", "templ", "razor" },
	root_markers = { "index.html", ".git", "go.mod" },
	settings = {
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
}
