return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				version = "v2.*",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					local luasnip = require("luasnip")

					vim.keymap.set({ "i", "s" }, "<C-l>", function()
						if luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						end
					end)
					vim.keymap.set({ "i", "s" }, "<C-h>", function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end)

					local function load_project_snippets()
						-- Construct the path to the project-specific snippet file
						local project_snippets_path = vim.fn.getcwd() .. "/.nvim/snippets.lua"

						-- Check if the file exists and load it
						if vim.fn.filereadable(project_snippets_path) == 1 then
							dofile(project_snippets_path)
							print("Loaded project snippets from: " .. project_snippets_path)
						else
							print("No project snippets found.")
						end
					end
					load_project_snippets()

					-- -- Run this function every time you enter a buffer in the project
					-- vim.api.nvim_create_autocmd("BufEnter", {
					-- 	callback = load_project_snippets,
					-- })
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
			fuzzy = {
				use_typo_resistance = true,
			},
		},
		opts_extend = { "sources.default" },
	},
}
