local function pos_equal(p1, p2)
	local r1, c1 = unpack(p1)
	local r2, c2 = unpack(p2)
	return r1 == r2 and c1 == c2
end

local function goto_error_then_hint(goto_function)
	local pos = vim.api.nvim_win_get_cursor(0)
	goto_function({ severity = vim.diagnostic.severity.ERROR, wrap = true })
	local pos2 = vim.api.nvim_win_get_cursor(0)
	if pos_equal(pos, pos2) then
		goto_function({ wrap = true })
	end
end

local function goto_error_then_hint_prev()
	return goto_error_then_hint(vim.diagnostic.goto_prev)
end

local function goto_error_then_hint_next()
	return goto_error_then_hint(vim.diagnostic.goto_next)
end

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>x", "<CMD>:q<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<C-[>", goto_error_then_hint_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<C-]>", goto_error_then_hint_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "[t", "<CMD>:tabp<cr>", { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "]t", "<CMD>:tabn<cr>", { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("x", "p", "P")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
