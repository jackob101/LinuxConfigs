-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--
local autoCmdGroup = vim.api.nvim_create_augroup("custom-autocommands", { clear = true })
vim.api.nvim_clear_autocmds({ group = autoCmdGroup }) -- For realoding the file using :luafile % so it won't create duplicate autocmds

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = autoCmdGroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "NvimTree_1",
	desc = "Hides line numers in nvim tree",
	group = autoCmdGroup,
	callback = function()
		vim.opt_local.statuscolumn = "%s"
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = autoCmdGroup,
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>lr", vim.lsp.buf.rename, "[L]sp [R]ename")
		map("<leader>la", vim.lsp.buf.code_action, "[L]sp Code [A]ction", { "n", "x" })
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = autoCmdGroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = autoCmdGroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = autoCmdGroup, buffer = event2.buf })
				end,
			})
		end
		vim.lsp.inlay_hint.enable(true)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
		if client and client.name == "svelte" then
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.js", "*.ts" },
				group = autoCmdGroup,
				callback = function(ctx)
					-- Here use ctx.match instead of ctx.file
					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
				end,
			})
		end
	end,
})

require("custom.organize-imports-pre-save")({ "*.go", "*.lua", "*.templ" }, { "source.organizeImports" })
