return {
    "folke/noice.nvim",
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
}
