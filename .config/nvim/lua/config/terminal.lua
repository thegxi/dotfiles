-- lua/config/terminal.lua
local M = {}

local state = {
	win = -1,
	buf = -1,
}

function M.toggle_terminal()
	-- 如果窗口已经存在且有效，则关闭它
	if vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_hide(state.win)
		return
	end

	-- 如果缓冲区不存在或无效，创建一个新的
	if not vim.api.nvim_buf_is_valid(state.buf) then
		state.buf = vim.api.nvim_create_buf(false, true) -- 不列在 buffer 列表中，是临时缓冲
	end

	-- 在下方打开水平分屏，高度设为 12 行（可根据喜好调整）
	vim.cmd("botright split")
	state.win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_height(state.win, 12)
	vim.api.nvim_win_set_buf(state.win, state.buf)

	-- 设置终端特有的样式：关闭行号，确保不显示多余 UI
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.signcolumn = "no"
	vim.opt_local.foldcolumn = "0"
	vim.opt_local.winfixheight = true -- 切换 Buffer 时保持高度不变

	-- 计算浮窗尺寸 (80% 屏幕大小)
	--	local width = math.ceil(vim.o.columns * 0.8)
	--	local height = math.ceil(vim.o.lines * 0.8)
	--	local col = math.ceil((vim.o.columns - width) / 2)
	--	local row = math.ceil((vim.o.lines - height) / 2)

	-- 打开圆角浮窗
	-- state.win = vim.api.nvim_open_win(state.buf, true, {
	-- 	relative = "editor",
	-- 	width = width,
	-- 	height = height,
	-- 	col = col,
	-- 	row = row,
	-- 	style = "minimal",
	-- 	border = "rounded", -- 你的圆角坚持
	-- })

	-- 如果是新缓冲区，启动终端
	if vim.bo[state.buf].buftype ~= "terminal" then
		vim.fn.termopen(os.getenv("SHELL") or "bash")
		vim.cmd("startinsert") -- 自动进入插入模式
	end
end

return M
