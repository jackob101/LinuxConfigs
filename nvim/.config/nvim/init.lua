require("options")
require("autocommands")
require("commands")

require("custom.pickers")
require("custom.string_utils")

local pluginConfigs = require("plugin-configs")

vim.pack.add({
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/L3MON4D3/LuaSnip",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/MagicDuck/grug-far.nvim",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/igorlfs/nvim-dap-view",
})

local function setupPlugin(name)
	local config = pluginConfigs[name]
	require(name).setup(config)
end

require("luasnip.loaders.from_vscode").lazy_load()

setupPlugin("lazydev")
setupPlugin("blink.cmp")
setupPlugin("nvim-tree")
setupPlugin("conform")
setupPlugin("gitsigns")
setupPlugin("mini.ai")
setupPlugin("mini.pairs")
setupPlugin("mini.pick")
setupPlugin("mini.extra")
setupPlugin("ibl")
setupPlugin("mini.surround")

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		{ mode = { "n", "x" }, keys = "<Leader>" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		{ mode = "i", keys = "<C-x>" },
		{ mode = { "n", "x" }, keys = "g" },
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = { "n", "x" }, keys = "z" },
	},
	window = {
		delay = 500,
	},
	clues = {
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
		{ mode = "n", keys = "<leader>p", desc = "Pickers" },
		{ mode = "n", keys = "<leader>t", desc = "Toggles" },
	},
})

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = {
			[""] = "msg",
			empty = "cmd",
			bufwrite = "msg",
			confirm = "cmd",
			emsg = "pager",
			echo = "msg",
			echomsg = "msg",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "msg",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "msg",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "msg",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",
			typed_cmd = "cmd",
		},
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.3,
			timeout = 5000,
		},
		pager = {
			height = 0.5,
		},
	},
})

vim.lsp.config("*", {
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true, -- Notify LSP about file changes
			},
		},
	},
})

vim.lsp.enable({
	"luals",
	"gopls",
	"typescript-language-server",
	"templ",
	"html",
	"emmet-language-server",
	"css-lsp",
	"zls",
	"qmlls",
	"ltex",
	"bash-lsp",
	"postgres-lsp",
})

require("keymaps")
require("macro")
require("lsp-progress")
require("debuger")
vim.cmd.colorscheme("kanagawa-dragon")
vim.cmd.hi("EndOfBuffer guifg=bg")

-- vim.treesitter.language.add("go")
local filetypes = {
	tsx = { "typescriptreact", "typescript.tsx" },
	typescript = { "ts" },
}

for lang, ft in pairs(filetypes) do
	vim.treesitter.language.register(lang, ft)
end
