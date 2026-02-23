TPickers = {}

function TPickers.getParams(extra)
	local win = vim.api.nvim_get_current_win()
	return function(client)
		local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
		return vim.tbl_extend("force", params, extra)
	end
end

function TPickers.create_picker_for_action(action, params)
	vim.lsp.buf_request_all(0, action, params, function(results_per_client)
		local items = {}
		local first_encoding
		local errors = {}

		for client_id, result_or_error in pairs(results_per_client) do
			local err, result = result_or_error.err, result_or_error.result
			if err then
				errors[client_id] = err
			else
				if result ~= nil then
					local locations = {}
					if not vim.islist(result) then
						vim.list_extend(locations, { result })
					else
						vim.list_extend(locations, result)
					end

					local offset_encoding = vim.lsp.get_client_by_id(client_id).offset_encoding

					if not vim.tbl_isempty(result) then
						first_encoding = offset_encoding
					end

					vim.list_extend(items, vim.lsp.util.locations_to_items(locations, offset_encoding))
				end
			end
		end

		if not vim.tbl_isempty(errors) then
			vim.print(errors)
		end

		local pickerItems = {}
		for index, value in ipairs(items) do
			local text = value.text:gsub("\t", "")
			table.insert(pickerItems, {
				lnum = value.lnum,
				path = value.filename,
				text = string.format("%s | %s | %s", TStrings.ensure_text_width(value.filename, 25), value.lnum, text),
			})
		end
		MiniPick.start({ source = {
			items = pickerItems,
		} })
	end)
end

function TPickers.lspReferences()
	local extra = {
		context = { includeDeclaration = true },
	}
	TPickers.create_picker_for_action("textDocument/references", TPickers.getParams(extra))
end

function TPickers.lspDefinitions()
	TPickers.create_picker_for_action("textDocument/definition", TPickers.getParams({}))
end

function TPickers.lspTypeDefinition()
	TPickers.create_picker_for_action("textDocument/typeDefinition", TPickers.getParams({}))
end

function TPickers.lspImplementation()
	TPickers.create_picker_for_action("textDocument/implementation", TPickers.getParams({}))
end

function TPickers.lspSymbols()
	local params = TPickers.getParams({})
	vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result, ctx, _)
		if err then
			print("error", err)
			return
		end

		if not result or vim.tbl_isempty(result) then
			return
		end

		local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
		local locations = vim.lsp.util.symbols_to_items(result or {}, 0, client.offset_encoding) or {}

		vim.print(locations)

		local items = {}
		for i, location in ipairs(locations) do
			local item = {
				text = string.format("%s | %s | %s", location.kind, location.lnum, location.text),
				lnum = location.lnum,
				bufnr = location.bufnr,
			}
			table.insert(items, item)
		end

		MiniPick.start({ source = {
			items = items,
		} })
	end)
end
