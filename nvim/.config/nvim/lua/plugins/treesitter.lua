return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" } },
		build = ":TSUpdate",
		lazy = false,
		branch = "master",
		-- main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true, disable = { "ruby" } },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select around function/method" },
						["if"] = { query = "@function.inner", desc = "Select inside function/method" },
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					},
					-- include_surrounding_whitespace = true,
				},
			},
		},
		config = function(opts)
			require("nvim-treesitter.configs").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
