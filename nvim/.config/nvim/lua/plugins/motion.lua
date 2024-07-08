return {
	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		config = function()
			require("leap").setup({})
			vim.keymap.set("n", "<leader>h", "<Plug>(leap)")
		end,
	},
}
