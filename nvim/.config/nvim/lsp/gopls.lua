-- print("Hi")
-- local mason = require("mason")
-- print(mason)
return {
	cmd = { "gopls" },
	root_markers = { "go.mod", ".git" },
	filetypes = { "go" },
}
