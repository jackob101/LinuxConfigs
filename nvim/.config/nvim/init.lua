require("options")
require("autocommands")
require("lazy_setup")
require("commands")

TAPI = {}
require("custom.pickers")
require("custom.string_utils")

require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ import = "plugins" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
	change_detection = {
		notify = false,
	},
})

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
	-- "csharp_ls",
	-- "golangci_lint_langserver",
	-- "htmx-lsp",
})

vim.cmd.colorscheme("kanagawa-dragon")
vim.cmd.hi("EndOfBuffer guifg=bg")
