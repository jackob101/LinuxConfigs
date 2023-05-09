return {
  "nvim-lua/plenary.nvim",
  "folke/tokyonight.nvim",
  "folke/tokyonight.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "p00f/nvim-ts-rainbow",
  "nvim-treesitter/playground",
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
  "onsails/lspkind.nvim",
  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "hrsh7th/cmp-buffer",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "hrsh7th/cmp-path",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "hrsh7th/cmp-cmdline",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "saadparwaiz1/cmp_luasnip",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
  },
  "moll/vim-bbye",
  "elkowar/yuck.vim",
  "bhurlow/vim-parinfer",
}
