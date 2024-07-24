-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

local normalFloat = vim.api.nvim_get_hl_by_name("Normal", true)
local bgDim = "#1b1b1b"
vim.print(dark)

-- local colors = require("catppuccin.palettes").get_palette()
local TelescopeColor = {
	-- TelescopeMatching = { fg = colors.flamingo }, TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
	TelescopePromptPrefix = { bg = bgDim },
	TelescopePromptNormal = { bg = bgDim },
	TelescopeResultsNormal = { bg = bgDim },
	TelescopePreviewNormal = { bg = bgDim },
	TelescopePromptBorder = { fg = bgDim, bg = bgDim },
	TelescopeResultsBorder = { bg = bgDim, fg = bgDim },
	TelescopePreviewBorder = { bg = bgDim, fg = bgDim },
	TelescopePromptTitle = { bg = bgDim, fg = "#e2cca9" },
	-- TelescopeResultsTitle = { fg = colors.mantle },
	-- TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
}

for hl, col in pairs(TelescopeColor) do
	vim.api.nvim_set_hl(0, hl, col)
end -- Enable telescope extensions, if they are installed

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

local function find_files_all()
	builtin.find_files({ hidden = true })
end

-- See `:help telescope.builtin`

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sF", find_files_all, { desc = "[S]earch [F]iles" })
-- vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", function()
	builtin.diagnostics({ bufnr = 0 })
end, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sD", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
