local api = vim.api

---@type integer?
local win_id = nil

---@type integer?
local buf_id = nil

---@type { row: integer, col_offset: integer }
local config = {
	row = 2,
	col_offset = 4,
}

---@return nil
local function open_banner()
	buf_id = api.nvim_create_buf(false, true)

	win_id = api.nvim_open_win(buf_id, false, {
		relative = "editor",
		width = 20,
		height = 1,
		row = vim.o.lines - vim.o.cmdheight - 5,
		col = vim.o.columns - 20,
		style = "minimal",
		border = "bold",
		focusable = false,
		zindex = 150,
	})

	api.nvim_set_option_value("winhighlight", "Normal:NormalFloat", { win = win_id })
end

local group = api.nvim_create_augroup("LspProgressGroup", { clear = true })

vim.api.nvim_create_autocmd("LspProgress", {
	group = group,
	callback = function(ev)
		if buf_id == nil then
			open_banner()
		end
		local value = ev.data.params.value
		if value.kind == "report" then
			local text = " " .. value.title .. " " .. value.message .. " "
			local width = #text
			api.nvim_buf_set_lines(buf_id, 0, -1, false, { text })
			if api.nvim_win_is_valid(win_id) then
				api.nvim_win_set_config(win_id, {
					relative = "editor",
					width = width,
					col = vim.o.columns - width - 4,
					row = vim.o.lines - vim.o.cmdheight - 5,
				})
			end
		elseif value.kind == "end" then
			if api.nvim_win_is_valid(win_id) then
				api.nvim_win_close(win_id, false)
			end
		end
	end,
})
