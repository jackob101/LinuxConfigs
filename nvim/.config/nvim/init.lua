require("options")
require("autocommands")
require("lazy_setup")
require("commands")
require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	{ import = "plugins" },
	--
	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes last telescope search
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
-- vim.lsp.config.gopls = {
-- 	cmd = { "gopls" },
-- 	root_markers = { "go.mod", ".git" },
-- 	filetypes = { "go" },
-- }
--
