vim.api.nvim_create_user_command("SnippetsReload", function()
	require("snippets").reload_snippets()
end, { desc = "Reloads luasnip snippets" })

vim.api.nvim_create_user_command("LspRefresh", function(opts)
	local clients = {}
	if opts.args ~= nil then
		clients[1] = vim.lsp.get_clients({ name = opts.args })[1]
	else
		clients = vim.lsp.get_clients()
	end
	for _, client in ipairs(clients) do
		print("updating " .. client.name)
		client.notify("workspace/didChangeWatchedFiles", {
			changes = {
				{
					uri = vim.uri_from_fname(vim.fn.getcwd()),
					type = 2, -- 2 = Changed
				},
			},
		})
	end
end, { desc = "Reloads the lsp server", nargs = "?" })

vim.api.nvim_create_user_command("GoplsRefresh", function()
	local files = vim.fn.glob("**/*_templ.go", true, true)

	for _, f in ipairs(files) do
		-- create a hidden scratch buffer
		local buf = vim.api.nvim_create_buf(false, true) -- listed=false, scratch=true
		-- read the file content into the buffer
		local lines = vim.fn.readfile(f)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		-- set buffer options so LSP treats it as a Go file
		vim.api.nvim_buf_set_option(buf, "filetype", "go")
		vim.api.nvim_buf_set_name(buf, f) -- gives the correct URI for LSP
		-- attach LSP if needed (if gopls is already attached to this workspace, notifications go automatically)
		for _, client in ipairs(vim.lsp.get_clients({ name = "gopls" })) do
			vim.lsp.buf_attach_client(buf, client.id)
		end
		-- immediately wipe buffer (triggers didClose)
		vim.api.nvim_buf_delete(buf, { force = true })
	end
end, { desc = "Refresh gopls in background for all generated files" })
