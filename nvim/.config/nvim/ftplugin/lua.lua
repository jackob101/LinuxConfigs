local isEditingConfig = string.find(vim.fn.getcwd(0), ".config/nvim")

if isEditingConfig then
	-- Keybind for reloading config files without having to type :luafile %
	vim.keymap.set("n", "<leader>cR", ":luafile %<CR>", { desc = "Reload current lua file" })
end
