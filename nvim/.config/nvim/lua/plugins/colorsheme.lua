return {
    {
        "sainnhe/gruvbox-material",
        init = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_background = "medium"
        end,
    },
    {
        {
            "LazyVim/LazyVim",
            opts = {
                colorscheme = "gruvbox-material",
            },
        },
    },
}
