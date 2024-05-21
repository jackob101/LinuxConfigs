vim.filetype.add({
	extension = {
		nix = "nix",
	},
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
