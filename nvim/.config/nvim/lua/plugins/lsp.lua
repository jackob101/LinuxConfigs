return {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        keys[#keys + 1] = {
            "<leader>th",
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end,
            desc = "[T]oggle Inlay [H]ints",
        }
    end,
}
