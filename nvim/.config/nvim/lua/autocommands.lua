-- Highlight when yanking (copying) text;
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

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = args.match
		if vim.treesitter.language.get_lang(ft) then
			pcall(vim.treesitter.start)
		end
	end,
})

require("custom.organize-imports-pre-save")({ "*.go", "*.lua", "*.templ" }, { "source.organizeImports" })

-- ui2 stuff

vim.api.nvim_create_autocmd("FileType", {
	pattern = "msg",
	callback = function()
		local ui2 = require("vim._core.ui2")
		local win = ui2.wins and ui2.wins.msg
		if win and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_set_option_value(
				"winhighlight",
				"Normal:NormalFloat,FloatBorder:FloatBorder",
				{ scope = "local", win = win }
			)
		end
	end,
})

local ui2 = require("vim._core.ui2")
local msgs = require("vim._core.ui2.messages")
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
	orig_set_pos(tgt)
	if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
		pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
			relative = "editor",
			anchor = "NE",
			row = 1,
			col = vim.o.columns - 1,
			border = "bold",
		})
	end
end

-- vim.api.nvim_create_autocmd("LspProgress", {
-- 	callback = function(ev)
-- 		local value = ev.data.params.value
-- 		vim.api.nvim_echo({ { value.message or "done" } }, false, {
-- 			id = "lsp." .. ev.data.client_id,
-- 			kind = "progress",
-- 			source = "vim.lsp",
-- 			title = value.title,
-- 			status = value.kind ~= "end" and "running" or "success",
-- 			percent = value.percentage,
-- 		})
-- 	end,
-- })
