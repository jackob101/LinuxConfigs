-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--
local autoCmdGroup = vim.api.nvim_create_augroup("custom-autocommands", { clear = true })
vim.api.nvim_clear_autocmds({ group = autoCmdGroup }) -- For realoding the file using :luafile % so it won't create duplicate autocmds

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = autoCmdGroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "NvimTree_1",
	desc = "Hides line numers in nvim tree",
	group = autoCmdGroup,
	callback = function()
		vim.opt_local.statuscolumn = "%s"
	end,
})
