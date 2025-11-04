return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/zls" },
	root_markers = { ".git", "build.zig" },
	filetypes = { "zig" },
	settings = {
		zls = {
			enable_build_on_save = true,
			build_on_save_step = "check",
		},
	},
}
