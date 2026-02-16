vim.g.user_emmet_leader_key = "<C-Z>"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} "

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.wrap = false
vim.opt.breakindent = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
--
vim.o.updatetime = 250
vim.o.swapfile = false
-- vim.cmd(
-- 	[[autocmd CursorHold,CursorHoldI * lua ]]
-- )
local function lspSymbol(name, icon)
	vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, numhl = "DiagnosticDefault" .. name })
end
lspSymbol("Hint", "")
lspSymbol("Warn", "")
lspSymbol("Error", "")

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	severity_sort = true,
	float = {
		source = true,
		border = "single",
		severity_sort = true,
		format = function(diagnostic)
			return string.format(
				"%s (%s) [%s]",
				diagnostic.message,
				diagnostic.source,
				diagnostic.code or diagnostic.user_data.lsp.code
			)
		end,
	},
	jump = {
		float = true,
	},
})

if vim.g.have_nerd_font then
	local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
	local diagnostic_signs = {}
	for type, icon in pairs(signs) do
		diagnostic_signs[vim.diagnostic.severity[type]] = icon
	end
	vim.diagnostic.config({ signs = { text = diagnostic_signs } })
end
