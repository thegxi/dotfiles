vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform" },
})

local conform = require("conform")
conform.setup({
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
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- 保存时自动格式化
	format_on_save = function(bufnr)
		-- Disable "format_on_save lsp_fallback" for languages that don't
		-- have a well standardized coding style. You can add additional
		-- languages here or re-enable it for the disabled ones.
		local disable_filetypes = { c = true, cpp = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		else
			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end
	end,
	-- NOTE: You can customize each formatter just like this.
	formatters = {
		ocamlformat = {
			prepend_args = {
				"--if-then-else",
				"vertical",
				"--break-cases",
				"fit-or-vertical",
				"--type-decl",
				"sparse",
			},
		},
	},
})
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		conform.format({
			async = true,
			lsp_fallback = true,
		})
	end,
})
