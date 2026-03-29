return {
	name = "clangd",
	-- --header-insertion=never: 防止自动导入头文件导致乱序
	-- --background-index: 开启后台索引
	-- -j=12: 根据你的 CPU 核心数调整并发数
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	-- 0.11 推荐方式：寻找项目根目录
	root_dir = vim.fs.root(0, { ".clangd", ".clang-format", "compile_commands.json", "compile_flags.txt", ".git" }),

	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},

	on_attach = function(client, bufnr)
		-- 0.11.x 的 Inlay Hints 联动
		local wk = require("which-key")
		wk.add({
			{ "<leader>l", group = "LSP", buffer = bufnr },
			{
				"<leader>lh",
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end,
				desc = "Toggle Inlay Hints",
				buffer = bufnr,
			},
			{ "<leader>ls", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header", buffer = bufnr },
		})
	end,
}
