return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- 启动时加载
		priority = 1000, -- 确保主题在插件加载时优先
		config = function()
			-- Tokyonight 配置
			require("tokyonight").setup({
				style = "storm", -- storm, night, day, moon
				transparent = false, -- 背景透明
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
					functions = { bold = true },
					variables = {},
					conditionals = { italic = true },
					loops = {},
					operators = {},
					types = {},
					numbers = {},
					booleans = {},
					properties = {},
					strings = {},
					methods = {},
				},
				sidebars = { "qf", "help", "terminal", "NvimTree" }, -- 特定 sidebar 背景
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = true, -- Lualine 中加粗模式字符
			})

			-- 设置 colorscheme
			vim.cmd([[colorscheme tokyonight]])

			-- 选配：lualine.nvim 与 tokyonight 风格一致
			local lualine = require("lualine")
			lualine.setup({
				options = {
					theme = "tokyonight",
					component_separators = "|",
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- 确保主题插件最先加载
		config = function()
			-- 基础配置：可以根据喜好调整对比度 (hard, medium, soft)
			require("gruvbox").setup({
				terminal_colors = true, -- 复制主题颜色到内置 terminal
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- 翻转部分高亮颜色
				contrast = "hard", -- 建议选择 hard，看起来更清晰干练
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			-- 应用主题
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
