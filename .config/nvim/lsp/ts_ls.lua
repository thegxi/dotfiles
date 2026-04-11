return {
	name = "ts_ls",
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	-- 0.11 推荐的根目录查找方式，优先找 package.json
	root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),

	-- 性能优化：禁用不常用的内置功能，减轻内存压力
	init_options = {
		hostInfo = "neovim",
		maxTsServerMemory = 4096, -- 针对大项目调高内存限制
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			includeCompletionsForModuleExports = true,
		},
	},

	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all", -- 类似 VSCode 的参数名提示
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayVariableTypeHints = true,
			},
		},
	},

	-- LSP 绑定后的操作
	on_attach = function(client, bufnr)
		-- 禁用 ts_ls 的格式化功能（如果你打算用 Prettier/Conform）
		-- client.server_capabilities.documentFormattingProvider = false

		-- 联动 Which-Key 提示
		local wk = require("which-key")
		wk.add({
			{ "<leader>l", group = "LSP", buffer = bufnr },
			{ "<leader>lo", "<cmd>TypescriptOrganizeImports<cr>", desc = "Organize Imports", buffer = bufnr },
			{ "<leader>li", "<cmd>TypescriptAddMissingImports<cr>", desc = "Add Missing Imports", buffer = bufnr },
			{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename", buffer = bufnr },
		})
	end,
}
