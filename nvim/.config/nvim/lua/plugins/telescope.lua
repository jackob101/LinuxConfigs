return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {
				--
				-- },

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local function ivy_style(picker_ref)
				return function()
					picker_ref(require("telescope.themes").get_ivy({}))
				end
			end

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", ivy_style(builtin.help_tags), { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", ivy_style(builtin.keymaps), { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", ivy_style(builtin.find_files), { desc = "[S]earch [F]iles" })
			vim.keymap.set(
				"n",
				"<leader>ss",
				ivy_style(builtin.lsp_document_symbols),
				{ desc = "[S]earch document [s]ymbols" }
			)
			vim.keymap.set("n", "<leader>sw", ivy_style(builtin.grep_string), { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", ivy_style(builtin.live_grep), { desc = "[S]earch by [G]rep" })
			vim.keymap.set(
				"n",
				"<leader>sD",
				ivy_style(builtin.diagnostics),
				{ desc = "[S]earch workspace [D]iagnostics" }
			)
			vim.keymap.set(
				"n",
				"<leader>sd",
				ivy_style(function()
					builtin.diagnostics({ bufnr = 0 })
				end),
				{ desc = "[S]earch buffer [D]iagnostics" }
			)
			vim.keymap.set("n", "<leader>sr", ivy_style(builtin.resume), { desc = "[S]earch [R]esume" })
			vim.keymap.set(
				"n",
				"<leader>s.",
				ivy_style(builtin.oldfiles),
				{ desc = '[S]earch Recent Files ("." for repeat)' }
			)
			vim.keymap.set("n", "<leader><leader>", ivy_style(builtin.buffers), { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
