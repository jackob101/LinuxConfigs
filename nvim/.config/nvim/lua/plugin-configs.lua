function miniPickWindowConfig()
	return {
		anchor = "NW",
		height = math.floor(0.4 * vim.o.lines),
		width = vim.o.columns,
		border = { "─", "─", "─", " ", " ", " ", " ", " " },
	}
end

return {
	["lazydev"] = {
		enabled = true,
		library = {
			-- Load luvit types when the `vim.uv` word is found
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
	["blink.cmp"] = {
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
			default = { "lsp", "path", "buffer" },
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
	["nvim-tree"] = {
		diagnostics = {
			show_on_dirs = true,
			enable = true,
		},
	},
	["conform"] = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters = {
			csharpier_native = {
				command = "csharpier",
				args = {
					"format",
					"--write-stdout",
				},
				to_stdin = true,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			sql = { "sqlfluff" },
			vue = { "prettier" },
			php = { "easy-coding-standard" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			cs = { "csharpier_native" },
			templ = { "templ" },
			yaml = { "yamlfmt" },
		},
	},
	["gitsigns"] = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "┃" },
			topdelete = { text = "┃" },
			changedelete = { text = "┃" },
		},
	},
	["mini.ai"] = { n_lines = 500 },
	["mini.pick"] = {
		window = {
			config = miniPickWindowConfig,
			prompt_prefix = ">",
		},
	},
	["ibl"] = {
		scope = {
			show_start = false,
		},
	},
	["dap"] = {},
}
