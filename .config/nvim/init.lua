-- basic options
require("config.options")
-- package manager
require("config.lazy")
require("config.terminal")
require("config.keymap")
require("config.dap")

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("jdtls")
vim.lsp.enable("pyright")
vim.lsp.enable("gopls")

vim.lsp.enable("css-lsp")
vim.lsp.enable("html-lsp")
vim.lsp.enable("vtsls")
vim.lsp.enable("ts_ls")

if vim.g.neovide then
	-- 字体设置：使用你喜欢的 Maple Mono，字号 15
	-- Neovide 的字体格式为 "字体名:h字号"
	vim.o.guifont = "Maple Mono:h13"

	-- 极简 UI：隐藏窗口装饰（标题栏等），让界面更纯净
	vim.g.neovide_window_decorations = false

	-- 动态背景透明度 (配合你的 Matugen 系统)
	-- 0.8 到 0.9 之间通常能获得良好的现代感
	vim.g.neovide_opacity = 0.9
	vim.g.neovide_normal_opacity = 0.9
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_corner_preference = "round"
	vim.g.neovide_window_blurred = true
	vim.g.neovide_position_animation_length = 0.15
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_scroll_animation_far_lines = 1
	vim.g.neovide_progress_bar_enabled = true
	vim.g.neovide_progress_bar_height = 5.0
	vim.g.neovide_progress_bar_animation_speed = 200.0
	vim.g.neovide_progress_bar_hide_delay = 0.2
	vim.g.neovide_hide_mouse_when_typing = false
	vim.g.neovide_underline_stroke_scale = 1.0
	vim.g.neovide_theme = "auto"
	vim.g.experimental_layer_grouping = false
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.150
	vim.g.neovide_cursor_short_animation_length = 0.04
	vim.g.neovide_cursor_trail_size = 1.0
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_vfx_mode = "railgun"

	-- 刷新率优化（匹配你的显示器）
	vim.g.neovide_refresh_rate = 60
end
