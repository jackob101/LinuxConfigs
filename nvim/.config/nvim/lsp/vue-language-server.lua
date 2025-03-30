return {
	cmd = { vim.fn.stdpath("data") .. "--stdio" },
	root_markers = { "package.json", ".git" },
	filetypes = { "vue" },
	single_file_support = true,
	settings = {
		typescript = {
			tsdk = vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server",
		},
	},
}
-- local volar_init_options = {
--   typescript = {
--     tsdk = '',
--   },
-- }

-- return {
--   default_config = {
--     cmd = { vim.fn.stdpath("data") .. "/mason/bin/vue-language-server", '--stdio' },
--     filetypes = { 'vue' },
--     root_dir = { 'package.json', ".git" },
--     init_options = volar_init_options,
--     on_new_config = function(new_config, new_root_dir)
--       if
--         new_config.init_options
--         and new_config.init_options.typescript
--         and new_config.init_options.typescript.tsdk == ''
--       then
--         new_config.init_options.typescript.tsdk = vim.fn.stdpath("data") .. '/mason/packages/typescript-language-server/node_modules/typescript/lib'
--       end
--     end,
--   },
