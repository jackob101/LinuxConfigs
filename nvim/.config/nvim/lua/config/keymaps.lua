-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<C-[>", goto_error_then_hint_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<C-]>", goto_error_then_hint_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("x", "p", "P")

vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
