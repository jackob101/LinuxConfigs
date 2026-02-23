TStrings = {}

function TStrings.ensure_text_width(text, width)
	local text_width = vim.fn.strchars(text)
	if text_width <= width then
		return text .. string.rep(" ", width - text_width)
	end
	return "…" .. vim.fn.strcharpart(text, text_width - width + 1, width - 1)
end
