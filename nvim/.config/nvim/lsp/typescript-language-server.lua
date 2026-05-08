return {
	cmd = { "typescript-language-server", "--stdio" },
	root_markers = { "package.json", ".git" },
	filetypes = { "typescript", "vue", "javascript", "typescriptreact", "javascriptreact" },
	single_file_support = true,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
}
