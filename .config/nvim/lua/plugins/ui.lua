return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- 获取 gruvbox 主题基础
			local custom_gruvbox = require("lualine.themes.gruvbox")

			-- 核心修复：强制中间栏 (c) 透明，消除圆角边缘的像素瑕疵
			-- "None" 或 nil 会让 lualine 不画背景，直接透出底层
			custom_gruvbox.normal.c.bg = "None"
			custom_gruvbox.insert.c.bg = "None"
			custom_gruvbox.visual.c.bg = "None"
			custom_gruvbox.replace.c.bg = "None"
			custom_gruvbox.command.c.bg = "None"
			custom_gruvbox.inactive.c.bg = "None"

			require("lualine").setup({
				options = {
					theme = custom_gruvbox,
					-- 使用 Gruvbox 风格的圆角分段
					component_separators = "",
					globalstatus = true,
					icons_enabled = true,
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return " " .. str
							end, -- 你的 Arch 标识
							padding = { right = 1 },
						},
					},
					lualine_b = {
						{ "filename", file_status = true, path = 1 }, -- path=1 显示相对路径
						"branch",
					},
					lualine_c = {
						{
							"diagnostics",
							symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
						},
					},
					lualine_x = {
						{
							-- 简单的 LSP 显示逻辑
							function()
								local clients = vim.lsp.get_clients({ bufnr = 0 })
								if #clients == 0 then
									return "No LSP"
								end
								return clients[1].name
							end,
							icon = " ",
							color = { fg = "#fabd2f", gui = "bold" }, -- 使用 Gruvbox 的黄色
						},
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = {
						{
							"location",
							padding = { left = 1 },
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
