return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
	root_markers = { "package.json", ".git" },
	filetypes = { "typescript", "vue", "javascript", "tsx", "typescriptreact" },
	single_file_support = true,
	settings = {
		-- plugins = {
		-- 	{
		-- 		name = "@vue/typescript-plugin",
		-- 		location = vim.fn.stdpath("data")
		-- 			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
		-- 		languages = { "javascript", "typescript", "vue" },
		-- 	},
		-- },
	},
}
