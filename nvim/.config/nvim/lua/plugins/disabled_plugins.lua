return {
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
    },
    {
        "akinsho/bufferline.nvim",
        enabled = false,
    },
    {
        "rcarriga/nvim-notify",
        enabled = false,
    },
    {
        "folke/noice.nvim",
        enabled = false,
        event = "VeryLazy",
        --TODO: REMOVE THIS once this issue is fixed: https://github.com/yioneko/vtsls/issues/159
        opts = {
            routes = {
                {
                    filter = {
                        event = "notify",
                        find = "Request textDocument/inlayHint failed",
                    },
                    opts = { skip = true },
                },
            },
        },
    },
    {
        "folke/flash.nvim",
        enabled = false,
    },
}
