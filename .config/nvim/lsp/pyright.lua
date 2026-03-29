return {
	name = "pyright",
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	-- 0.11 推荐方式：寻找项目根目录标识
	root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", ".git", "requirements.txt", "venv" }),

	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic", -- 可选 "strict" 如果你追求极致类型安全
				diagnosticMode = "workspace",
			},
		},
	},

	on_attach = function(client, bufnr)
		local wk = require("which-key")
		wk.add({
			{ "<leader>l", group = "LSP", buffer = bufnr },
			{ "<leader>li", "<cmd>PyrightOrganizeImports<cr>", desc = "Organize Imports", buffer = bufnr },
		})
	end,
}
