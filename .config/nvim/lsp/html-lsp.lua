return {
	name = "html",
	-- 注意：Arch 上通过 Mason 安装的名称通常是这个
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "htmldjango", "templ" },
	-- 0.11 推荐方式：寻找项目根目录
	root_dir = vim.fs.root(0, { "index.html", ".git", "package.json" }),

	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},

	settings = {
		html = {
			format = {
				templating = true,
				wrapLineLength = 120,
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
	},

	on_attach = function(client, bufnr)
		local wk = require("which-key")
		wk.add({
			{ "<leader>l", group = "LSP", buffer = bufnr },
			{
				"<leader>lf",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				desc = "Format Document",
				buffer = bufnr,
			},
		})
	end,
}
