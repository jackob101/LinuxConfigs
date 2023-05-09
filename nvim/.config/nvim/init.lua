local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- local plugins = {
--   ["folke/which-key.nvim"] = which_key_config,
--   ["windwp/nvim-autopairs"] = autopairs_config,
--   ["nvim-telescope/telescope-media-files.nvim"] = telescope_media_config,
--   ["nvim-telescope/telescope-project.nvim"] = telescope_projects_config,
--   ["nvim-telescope/telescope.nvim"] = telescope_config,
--   ["nvim-treesitter/nvim-treesitter"] = treesitter_config,
--   ["kyazdani42/nvim-tree.lua"] = nvim_tree_config,
--   ["L3MON4D3/LuaSnip"] = luasnip_config,
--   ["folke/tokyonight.nvim"] = {},
--   ["nvim-lua/popup.nvim"] = {},
--   ["nvim-lua/plenary.nvim"] = {},
--   ["p00f/nvim-ts-rainbow"] = {},
--   ["nvim-treesitter/playground"] = {},
--   ["onsails/lspkind.nvim"] = {},
--   ["hrsh7th/cmp-nvim-lsp"] = {},
--   ["hrsh7th/cmp-buffer"] = {},
--   ["hrsh7th/cmp-path"] = {},
--   ["hrsh7th/cmp-cmdline"] = {},
--   ["saadparwaiz1/cmp_luasnip"] = {},
--   ["moll/vim-bbye"] = {},
--   ["elkowar/yuck.vim"] = {},
--   ["bhurlow/vim-parinfer"] = {},
--   ["hrsh7th/nvim-cmp"] = cmp_config,
--   ["williamboman/mason.nvim"] = mason,
--   ["williamboman/mason-lspconfig.nvim"] = mason_lspconfig,
--   ["neovim/nvim-lspconfig"] = lsp_config,
--   ["jose-elias-alvarez/null-ls.nvim"] = null_ls_config,
--   ["akinsho/bufferline.nvim"] = bufferline_config,
--   ["simrat39/rust-tools.nvim"] = rust_tools_config,
--   ["phaazon/hop.nvim"] = hop_config,
--   ["lewis6991/gitsigns.nvim"] = gitsigns_config,
--   ["goolord/alpha-nvim"] = alpha_config,
--   ["numToStr/Comment.nvim"] = comment_config,
--   ["nvim-lualine/lualine.nvim"] = lualine_config,
--   ["akinsho/toggleterm.nvim"] = toggleterm_config,
--   ["lukas-reineke/indent-blankline.nvim"] = indentline_config,
--   ["j-hui/fidget.nvim"] = fidget_config,
--   ["ray-x/lsp_signature.nvim"] = signature_help_config,
--   ["folke/trouble.nvim"] = trouble_config,
-- }
--

require("options")
require("keymaps")
--require("lua.lazy")
--
require("lazy").setup("plugins")

require("colorscheme")
