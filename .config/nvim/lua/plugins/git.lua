return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- 依赖系统已安装过 lazygit (sudo pacman -S lazygit)
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- 设置浮窗的样式，匹配你的圆角审美
		vim.g.lazygit_floating_window_winblend = 0 -- 透明度
		vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" } -- 圆角字符
		vim.g.lazygit_floating_window_use_plenary = 1 -- 使用 plenary 创建窗口
	end,
}
