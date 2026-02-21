return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			require("mini.pairs").setup({})

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			local win_config = function(percent_width, percent_height)
				return function()
					local height = math.floor(0.618 * vim.o.lines)
					local width = math.floor(0.618 * vim.o.columns)
					return {
						anchor = "NW",
						height = height,
						width = width,
						row = math.floor(percent_height * (vim.o.lines - height)),
						col = math.floor(percent_width * (vim.o.columns - width)),
					}
				end
			end

			require("mini.pick").setup({

				window = { config = win_config(0.5, 0.5) },
			})
			require("mini.extra").setup()

			vim.keymap.set("n", "<leader>pk", MiniExtra.pickers.keymaps, { desc = "Keymaps" })
			vim.keymap.set("n", "<leader>pf", MiniPick.builtin.files, { desc = "Files on root" })
			vim.keymap.set("n", "<leader>pr", MiniPick.builtin.resume, { desc = "Resume previous pick" })
			vim.keymap.set("n", "<leader><leader>", MiniPick.builtin.buffers, { desc = "Open buffers" })
			vim.keymap.set("n", "<leader>pg", function()
				MiniPick.builtin.grep({ pattern = "" })
			end, { desc = "Grep on root dir" })
			vim.keymap.set("n", "<leader>p/", function()
				MiniPick.builtin.grep({ pattern = "", globs = { vim.fn.expand("%") } })
			end, { desc = "Current buffer grep" })
			vim.keymap.set("n", "<leader>pd", MiniExtra.pickers.diagnostic, { desc = "Diagnostics" })

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
