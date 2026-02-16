return {
	{
		"folke/tokyonight.nvim",
		enabled = enable,
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("tokyonight-night")
			vim.cmd.hi("Comment gui=none")
		end,
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		enabled = false,
		init = function()
			require("onedark").setup({
				style = "warm",
			})
			require("onedark").load()
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{
		"xero/miasma.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme miasma")
		end,
	},
	{
		"neanias/everforest-nvim",
		priority = 1000,
		enabled = true,
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
