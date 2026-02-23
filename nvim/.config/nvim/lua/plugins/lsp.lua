return {
	{
		"mattn/emmet-vim",
		ft = { "svelte", "html", "vue", "php", "templ" },
		config = function() end,
	},
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			enabled = true,
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"williamboman/mason.nvim",
		config = true,
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"gopls",
				"clangd",
				"typescript-language-server",
				"vue-language-server",
				"html-lsp",
				"css-lsp",
				"go-debug-adapter",
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{ "j-hui/fidget.nvim", opts = {} },
}
