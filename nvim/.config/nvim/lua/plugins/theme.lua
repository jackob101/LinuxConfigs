return {
	{
		"folke/tokyonight.nvim",
		enabled = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		init = function()
			require("onedark").setup({
				style = "warm",
			})
			require("onedark").load()
			vim.cmd.hi("Comment gui=none")
		end,
	},

	{
		"neanias/everforest-nvim",
		priority = 1000,
		enabled = false,
		init = function()
			---@diagnostic disable: missing-fields
			require("everforest").setup({
				background = "hard",
				ui_contrast = "high",
			})
			vim.cmd.colorscheme("everforest")
			vim.cmd.hi("EndOfBuffer guifg=bg")
		end,
	},
}
