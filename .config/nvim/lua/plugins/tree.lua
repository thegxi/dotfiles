return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false, -- 建议启动时加载，方便快速找文件
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			-- 1. 基础 UI 设置
			view = {
				width = 30,
				side = "left",
				-- 在这里可以开启相对行号，符合你的 Emacs/Nvim 习惯
				number = false,
				relativenumber = false,
			},
			-- 2. 渲染设置
			renderer = {
				group_empty = true, -- 合并空目录
				highlight_opened_files = "all", -- 高亮已打开的文件
				indent_markers = {
					enable = true, -- 显示层级线条
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			-- 3. 过滤设置
			filters = {
				dotfiles = false, -- 显示隐藏文件（如 .config）
				custom = { "^.git$" }, -- 过滤掉 .git 目录
			},
			-- 4. 交互设置
			actions = {
				open_file = {
					quit_on_open = false, -- 打开文件后不自动关闭目录树
					window_picker = { enable = false }, -- 禁用窗口选择器，操作更直接
				},
			},
		})
		-- 统一目录树的背景色为 Gruvbox 的深色
		vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#282828" })
		vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = "#282828" })
		-- 选中的文件显示为黄色
		vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#fabd2f", bold = true })
	end,
}
