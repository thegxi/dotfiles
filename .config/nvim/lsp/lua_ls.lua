return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				-- 识别 Neovim 的全局变量 'vim'，解决警告
				globals = { "vim" },
			},
			workspace = {
				-- 让服务器感知 Neovim 的运行时文件和已安装插件的库
				-- 在 0.11+ 中，这通常会自动处理，但显式写出来更稳
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- 禁用第三方库检测提示，减少干扰
			},
			telemetry = {
				enable = false, -- 保护隐私，不发送遥测数据
			},
			completion = {
				callSnippet = "Replace", -- 补全函数时自动带上括号和参数占位符
			},
		},
	},
}
