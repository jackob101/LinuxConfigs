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
	"https://github.com/folke/which-key.nvim",
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
require("which-key").setup({
	delay = 0,
	icons = {
		-- set icon mappings to true if you have a Nerd Font
		mappings = vim.g.have_nerd_font,
		-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
		-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
		keys = vim.g.have_nerd_font and {} or {
			Up = "<Up> ",
			Down = "<Down> ",
			Left = "<Left> ",
			Right = "<Right> ",
			C = "<C-…> ",
			M = "<M-…> ",
			D = "<D-…> ",
			S = "<S-…> ",
			CR = "<CR> ",
			Esc = "<Esc> ",
			ScrollWheelDown = "<ScrollWheelDown> ",
			ScrollWheelUp = "<ScrollWheelUp> ",
			NL = "<NL> ",
			BS = "<BS> ",
			Space = "<Space> ",
			Tab = "<Tab> ",
			F1 = "<F1>",
			F2 = "<F2>",
			F3 = "<F3>",
			F4 = "<F4>",
			F5 = "<F5>",
			F6 = "<F6>",
			F7 = "<F7>",
			F8 = "<F8>",
			F9 = "<F9>",
			F10 = "<F10>",
			F11 = "<F11>",
			F12 = "<F12>",
		},
	},

	-- Document existing key chains
	spec = {
		{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
	},
})
require("mini.ai").setup({ n_lines = 500 })
require("mini.pairs").setup({})
require("mini.surround").setup()
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

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

vim.keymap.set("n", "<leader>te", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tE", "<CMD>NvimTreeFindFile<CR>")

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
	-- "vue-language-server",
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
