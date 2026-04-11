require("options")
require("autocommands")
require("commands")

require("custom.pickers")
require("custom.string_utils")

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
})

require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Tab>"] = {},
		["<S-Tab>"] = {},
		["<C-k>"] = {},
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	signature = {
		enabled = true,
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
			},
		},
	},
	snippets = {
		preset = "luasnip",
	},
})
require("nvim-tree").setup({
	diagnostics = {
		show_on_dirs = true,
		enable = true,
	},
})
require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		local lsp_format_opt
		if disable_filetypes[vim.bo[bufnr].filetype] then
			lsp_format_opt = "never"
		else
			lsp_format_opt = "fallback"
		end
		return {
			timeout_ms = 500,
			lsp_format = lsp_format_opt,
		}
	end,
	formatters = {
		csharpier_native = {
			command = "csharpier",
			args = {
				"format",
				"--write-stdout",
			},
			to_stdin = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		sql = { "sqlfluff" },
		vue = { "prettier" },
		php = { "easy-coding-standard" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		cs = { "csharpier_native" },
		templ = { "templ" },
	},
})
require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "┃" },
		topdelete = { text = "┃" },
		changedelete = { text = "┃" },
	},
})
require("mini.ai").setup({ n_lines = 500 })
require("mini.pairs").setup({})
require("mini.surround").setup()
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
require("mini.pick").setup({
	window = {
		config = {
			anchor = "NW",
			height = math.floor(0.4 * vim.o.lines),
			width = vim.o.columns,
			border = { "─", "─", "─", " ", " ", " ", " ", " " },
		},
		prompt_prefix = ">",
	},
})
require("mini.extra").setup()
local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

require("keymaps")

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

vim.cmd.colorscheme("kanagawa-dragon")
vim.cmd.hi("EndOfBuffer guifg=bg")

-- vim.treesitter.language.add("go")
