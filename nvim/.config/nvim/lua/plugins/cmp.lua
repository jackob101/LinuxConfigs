return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-emoji",
            "L3MON4D3/LuaSnip",
        },
        keys = { -- This removes annoying TAB behaviour, where I'am sometimes far outside the snippet and want to indent
            -- but pressing tab jumpt to the snippets....
            {
                "<tab>",
                false,
                mode = "i",
            },
            {
                "<tab>",
                false,
                mode = "s",
            },
            {
                "<s-tab>",
                false,
                mode = { "i", "s" },
            },
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            opts.completion = { completeopt = "noselect" }
            opts.preselect = cmp.PreselectMode.None
            opts.experimental.ghost_text = false
            opts.mapping = {
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
                ["<C-k>"] = cmp.mapping(function()
                    if luasnip.expandable() then
                        luasnip.expand()
                    end
                end, { "i", "s" }),
            }

            opts.sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
            }
        end,
    },
}
