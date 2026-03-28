-- ensure_installed = {
-- LSPs...
--  "stylua",            -- Lua
--  "black", "isort",    -- Python
--  "goimports",         -- Go
--  "prettierd",         -- JS/TS/Vue/HTML (prettierd 比 prettier 更快)
--  "clang-format",      -- C/C++
--  "google-java-format" -- Java
--}
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		-- 定义不同语言使用的格式化器
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			go = { "goimports", "gofmt" },
			rust = { "rustfmt" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			vue = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			c = { "clang-format" },
			java = { "google-java-format" },
		},
		-- 保存时自动格式化
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
