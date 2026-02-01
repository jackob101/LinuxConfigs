vim.api.nvim_create_user_command("SnippetsReload", function()
	require("snippets").reload_snippets()
end, { desc = "Reloads luasnip snippets" })
