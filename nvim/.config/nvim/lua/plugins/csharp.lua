return {
	"seblyng/roslyn.nvim",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	opts = {
		settings = {
			["csharp|inlay_hints"] = {
				csharp_enable_inlay_hints_for_implicit_object_creation = true,
				csharp_enable_inlay_hints_for_implicit_variable_types = true,
			},
			["csharp|code_lens"] = {
				dotnet_enable_references_code_lens = true,
			},
		},
	},
	config = function(opts)
		require("roslyn").setup(opts)
		vim.filetype.add({
			extension = {
				razor = "razor",
				cshtml = "razor",
			},
		})
		-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		-- 	pattern = "*",
		-- 	callback = function()
		-- 		local clients = vim.lsp.get_clients({ name = "roslyn" })
		-- 		if not clients or #clients == 0 then
		-- 			return
		-- 		end
		-- 		local client = vim.lsp.get_clients({
		-- 			name = "roslyn",
		-- 			bufnr = vim.api.nvim_get_current_buf(),
		-- 		})[1]
		-- 		local buffers = vim.lsp.get_buffers_by_client_id(client.id)
		-- 		for _, buf in ipairs(buffers) do
		-- 			local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
		-- 			client:request("textDocument/diagnostic", params, nil, buf)
		-- 		end
		-- 	end,
		-- })
	end,
}
