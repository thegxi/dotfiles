return {
	name = "gopls",
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- 0.11 推荐方式：寻找 Go 项目根目录
	root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),

	settings = {
		gopls = {
			completeUnimported = true, -- 自动补全未导入的包
			usePlaceholders = true, -- 补全函数带参数占位符
			staticcheck = true, -- 开启高级静态检查
			analyses = {
				unusedparams = true, -- 检查未使用参数
				shadow = true, -- 检查变量覆盖
			},
			-- 0.11 开启内联提示，显示类型推断
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			gofumpt = true, -- 使用更严格的格式化（需安装 gofumpt）
		},
	},

	on_attach = function(client, bufnr)
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
			{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", buffer = bufnr },
		})

		-- 发动：保存时自动组织导入 (Go 特有逻辑) 并格式化
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				local params = vim.lsp.util.make_range_params()
				params.context = { only = { "source.organizeImports" } }
				-- 同步请求组织导入
				local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
				for _, res in pairs(result or {}) do
					for _, r in pairs(res.result or {}) do
						if r.edit then
							vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
						end
					end
				end
				-- 格式化代码
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
}
