return {
	cmd = { "ols" },
	filetypes = { "odin" },
	root_markers = { "ols.json", ".git", "*.odin" },
	init_options = {
		checker_args = "-strict-style",
		enable_snippets = true,
		enable_inlay_hints_params = true,
		enable_inlay_hints_default_params = true,
		enable_inlay_hints_implicit_return = true,
		enable_inlay_hints_optional_result = true,
		collections = {
			{ name = "builtin", path = vim.fn.expand("$HOME/.local/lib/builtin") },
		},
	},
}
