-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--

local function toggleDiagnosticLines()
	print(tostring(vim.diagnostic.config().virtual_lines))
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- vim.keymap.set("n", "<F2>", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
-- vim.keymap.set("n", "<C-F3>", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without without", noremap = true, silent = true })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save buffer" })

vim.keymap.set("n", "<leader>td", toggleDiagnosticLines, { desc = "Toggle virtual diagnostic lines" })
