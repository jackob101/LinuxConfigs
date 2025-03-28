return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				diagnostics = {
					show_on_dirs = true,
					enable = true,
				},
			})

			vim.keymap.set("n", "<leader>te", ":NvimTreeToggle<CR>")
			vim.keymap.set("n", "<leader>tE", "<CMD>NvimTreeFindFile<CR>")
		end,
	},
}
