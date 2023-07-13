return {
  {
    'rose-pine/neovim',
    enabled = false,
    priority = 1000,
    config = function()
      require('lazy').setup {
        { 'rose-pine/neovim', name = 'rose-pine' },
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    -- enabled = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
}
