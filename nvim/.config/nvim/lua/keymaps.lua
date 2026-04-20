local luasnip = require("luasnip")

local function toggleDiagnosticLines()
	print(tostring(vim.diagnostic.config().virtual_lines))
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without without", noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>td", toggleDiagnosticLines, { desc = "Toggle virtual diagnostic lines" })
vim.keymap.set("n", "<leader>;", "<S-a>;<ESC>", { desc = "Add ; at the end of the line" })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if luasnip.locally_jumpable(1) then
		luasnip.jump(1)
	end
end)
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if luasnip.locally_jumpable(-1) then
		luasnip.jump(-1)
	end
end)
vim.keymap.set({ "i", "n" }, "<C-S-k>", function()
	if luasnip.expandable() then
		luasnip.expand()
	end
end, { desc = "Expand snippet", silent = true })

vim.keymap.set("n", "<leader>te", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tE", "<CMD>NvimTreeFindFile<CR>")
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

-- git
vim.keymap.set("n", "<leader>tb", "<CMD>Gitsigns blame<CR>", { desc = "Toggle git blame" })
