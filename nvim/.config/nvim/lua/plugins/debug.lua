return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.keymap.set("n", "<leader>db", "<cmd>:DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<leader>do", "<cmd>:DapStepOver<CR>")
			vim.keymap.set("n", "<leader>dc", "<cmd>:DapContinue<CR>")

			---@class dap
			local dap = require("dap")
			dap.configurations = {
				go = {
					{
						type = "go",
						name = "Debug Package",
						request = "launch",
						program = "${fileDirname}",
					},
					{
						type = "go",
						name = "Debug workspace",
						request = "launch",
						program = "${workspaceFolder}",
						mode = "debug",
					},
					{
						type = "delve",
						name = "Debug",
						request = "launch",
						program = "${file}",
					},
					{
						type = "delve",
						name = "Debug test", -- configuration for debugging test files
						request = "launch",
						mode = "test",
						program = "${file}",
					},
					-- works with go.mod packages and sub packages
					{
						type = "delve",
						name = "Debug test (go.mod)",
						request = "launch",
						mode = "test",
						program = "./${relativeFileDirname}",
					},
				},
			}
			dap.adapters = {
				go = function(callback, config)
					if config.mode == "remote" and config.request == "attach" then
						callback({
							type = "server",
							host = config.host or "127.0.0.1",
							port = config.port or "38697",
						})
					else
						callback({
							type = "server",
							port = "${port}",
							executable = {
								command = "/home/jackob/.local/share/nvim/mason/bin/dlv",
								args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
								detached = vim.fn.has("win32") == 0,
							},
						})
					end
				end,
			}
		end,
	},
	{
		"igorlfs/nvim-dap-view",
		---@module 'dap-view'
		---@type dapview.Config
		opts = {},
	},
}
