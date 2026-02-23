return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				build = "make install_jsregexp",
				version = "v2.*",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					local luasnip = require("luasnip")

					-- vim.keymap.set({ "i", "s" }, "<C-l>", function()
					-- 	if luasnip.locally_jumpable(1) then
					-- 		luasnip.jump(1)
					-- 	end
					-- end)
					-- vim.keymap.set({ "i", "s" }, "<C-h>", function()
					-- 	if luasnip.locally_jumpable(-1) then
					-- 		luasnip.jump(-1)
					-- 	end
					-- end)
					-- vim.keymap.set({ "i", "n" }, "<C-k>", function()
					-- 	if luasnip.expandable() then
					-- 		luasnip.expand()
					-- 	else
					-- 		print("Not expandable")
					-- 	end
					-- end)

					require("snippets").reload_snippets()
				end,
			},
		},
		enabled = true,
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = {},
				["<S-Tab>"] = {},
				["<C-k>"] = {},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = {
				enabled = true,
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},
			},
			snippets = {
				preset = "luasnip",
			},
		},
		opts_extend = { "sources.default" },
	},
}
