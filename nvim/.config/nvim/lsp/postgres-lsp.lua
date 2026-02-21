return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/postgres-language-server", "lsp-proxy" },
	root_markers = { "postgres-language-server.jsonc" },
	filetypes = { "sql" },
	workspace_required = true,
}
