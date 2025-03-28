return {
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	enabled = false,
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-path",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-emoji",
	-- 		{
	-- 			"L3MON4D3/LuaSnip",
	-- 			-- follow latest release.
	-- 			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- 			-- install jsregexp (optional!).
	-- 			build = "make install_jsregexp",
	-- 			config = function()
	-- 				require("luasnip.loaders.from_vscode").lazy_load()
	-- 			end,
	-- 		},
	-- 		"rafamadriz/friendly-snippets",
	-- 	},
	-- 	keys = { -- This removes annoying TAB behaviour, where I'am sometimes far outside the snippet and want to indent
	-- 		-- but pressing tab jumpt to the snippets....
	-- 		{
	-- 			"<tab>",
	-- 			false,
	-- 			mode = "i",
	-- 		},
	-- 		{
	-- 			"<tab>",
	-- 			false,
	-- 			mode = "s",
	-- 		},
	-- 		{
	-- 			"<s-tab>",
	-- 			false,
	-- 			mode = { "i", "s" },
	-- 		},
	-- 	},
	-- 	---@param opts cmp.ConfigSchema
	-- 	opts = function(_, opts)
	-- 		local luasnip = require("luasnip")
	-- 		local cmp = require("cmp")
	-- 		opts.completion = { completeopt = "noselect" }
	-- 		opts.preselect = cmp.PreselectMode.None
	-- 		-- opts.experimental.ghost_text = false
	--
	-- 		opts.snippet = {
	-- 			expand = function(args)
	-- 				require("luasnip").lsp_expand(args.body)
	-- 			end,
	-- 		}
	-- 		opts.mapping = {
	-- 			["<Down>"] = cmp.mapping.select_next_item(),
	-- 			["<Up>"] = cmp.mapping.select_prev_item(),
	-- 			["<C-n>"] = cmp.mapping.select_next_item(),
	-- 			["<C-p>"] = cmp.mapping.select_prev_item(),
	-- 			["<C-y>"] = cmp.mapping.confirm({ select = true }),
	-- 			["<C-Space>"] = cmp.mapping.complete({}),
	-- 			["<C-l>"] = cmp.mapping(function()
	-- 				if luasnip.expand_or_locally_jumpable() then
	-- 					luasnip.expand_or_jump()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<C-h>"] = cmp.mapping(function()
	-- 				if luasnip.locally_jumpable(-1) then
	-- 					luasnip.jump(-1)
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<C-k>"] = cmp.mapping(function()
	-- 				print("test" .. tostring(luasnip.expandable()))
	-- 				if luasnip.expandable() then
	-- 					luasnip.expand()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 		}
	--
	-- 		opts.sources = {
	-- 			{ name = "nvim_lsp" },
	-- 			{ name = "luasnip" },
	-- 			{ name = "path" },
	-- 		}
	-- 	end,
	-- },
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
					vim.keymap.set({ "i", "n" }, "<C-k>", function()
						luasnip.expand()
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
