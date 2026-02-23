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
		map("gr", TPickers.lspReferences, "[G]oto [R]eferences")
		map("gd", TPickers.lspDefinitions, "[G]oto [R]eferences")
		map("gI", TPickers.lspImplementation, "[G]oto [I]mplementation")
		map("gD", TPickers.lspTypeDefinition, "Type [D]efinition")
		map("<leader>ps", TPickers.lspSymbols, "[D]ocument [S]ymbols")
		map("<leader>lr", vim.lsp.buf.rename, "[L]sp [R]ename")
		map("<leader>la", vim.lsp.buf.code_action, "[L]sp Code [A]ction", { "n", "x" })
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
		vim.lsp.inlay_hint.enable(false)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

require("custom.organize-imports-pre-save")({ "*.go", "*.lua", "*.templ" }, { "source.organizeImports" })
