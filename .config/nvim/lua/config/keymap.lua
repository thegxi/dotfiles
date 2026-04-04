local map = vim.keymap.set
local fzf = require("fzf-lua")
map("n", "<leader>ff", fzf.files, { silent = true, noremap = true, desc = "Fzf Files" })
map("n", "<leader>fg", fzf.live_grep, { silent = true, noremap = true, desc = "Fzf Grep" })
map("n", "<leader>fb", function()
	fzf.buffers()
end, { silent = true, noremap = true, desc = "Fzf Buffers" })
map("n", "<leader>fht", fzf.help_tags, { silent = true, noremap = true, desc = "Fzf Help" })
map("n", "<leader>fc", fzf.command_history, { silent = true, noremap = true, desc = "Command History" })

map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { silent = true, noremap = true, desc = "上一个 Buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { silent = true, noremap = true, desc = "下一个 Buffer" })
map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { silent = true, noremap = true, desc = "跳转到指定 Buffer" })
map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { silent = true, noremap = true, desc = "关闭指定 Buffer" })
-- 纯原生关闭 Buffer 逻辑，不依赖任何第三方插件
map("n", "<leader>bd", function()
	local bufnr = vim.api.nvim_get_current_buf()
	-- 如果是最后一个 buffer，直接删掉可能会关掉窗口，这里可以做个判断
	vim.cmd("bdelete")
end, { silent = true, noremap = true, desc = "Close Current Buffer" })

-- 快捷键：使用 <leader>e (Explorer)
map("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { silent = true, noremap = true, desc = "Toggle Explorer" })
-- 自动定位到当前文件
map(
	"n",
	"<leader>ef",
	"<cmd>NvimTreeFindFile<cr>",
	{ silent = true, noremap = true, desc = "Find current file in Tree" }
)

-- 代码格式化
map("n", "<leader>fc", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- 移动优化：在开启了 wrap（折行）时，按 j/k 也是按视觉行移动
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 快速保存/退出 (既然用了 cmdheight=0，减少手动输入 :w 的频率)
map("n", "<leader>w", "<cmd>w<cr>", { silent = true, noremap = true, desc = "Save Buffer" })
map("n", "<leader>q", "<cmd>q<cr>", { silent = true, noremap = true, desc = "Quit Window" })

-- 更好的缩进体验 (视觉模式下缩进后不会丢失选中状态)
map("v", "<", "<gv", { silent = true, noremap = true })
map("v", ">", ">gv", { silent = true, noremap = true })

-- 剪贴板优化：x 不会覆盖你的寄存器，只删除不复制
map("n", "x", '"_x', { silent = true, noremap = true })

-- 跳转到定义 (也可以用 ctrl + ])
map("n", "gd", vim.lsp.buf.definition, { silent = true, noremap = true, desc = "LSP Definition" })
map("n", "gr", vim.lsp.buf.references, { silent = true, noremap = true, desc = "LSP References" })
map("n", "gI", vim.lsp.buf.implementation, { silent = true, noremap = true, desc = "LSP Implementation" })

-- 悬浮文档 (按两次可以进入文档窗口进行复制)
map("n", "K", vim.lsp.buf.hover, { silent = true, noremap = true, desc = "LSP Hover" })

-- 变量重命名 (0.11+ 的 rename 默认在浮窗内，非常现代)
map("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, noremap = true, desc = "LSP Rename" })

-- 代码操作 (快速修复错误)
map("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, noremap = true, desc = "LSP Code Action" })

-- 诊断跳转 (左下角出现红点时快速跳转)
map("n", "[d", vim.diagnostic.goto_prev, { silent = true, noremap = true, desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { silent = true, noremap = true, desc = "Next Diagnostic" })

-- 快速分屏
map("n", "<leader>sv", "<cmd>vsplit<cr>", { silent = true, noremap = true, desc = "Split Vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { silent = true, noremap = true, desc = "Split Horizontal" })

-- 窗口间快速跳转 (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", { silent = true, noremap = true, desc = "Focus on left" })
map("n", "<C-j>", "<C-w>j", { silent = true, noremap = true, desc = "Focus on down" })
map("n", "<C-k>", "<C-w>k", { silent = true, noremap = true, desc = "Focus on up" })
map("n", "<C-l>", "<C-w>l", { silent = true, noremap = true, desc = "Focus on right" })

-- 如果补全窗开着，按 Esc 先关窗；如果关着，再退出插入模式
-- map("i", "<Esc>", function()
-- 	if require("blink.cmp").is_visible() then
-- 		require("blink.cmp").hide()
-- 	else
-- 		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
-- 	end
-- end)
map("i", "<Esc>", function()
	if require("blink.cmp").is_visible() then
		require("blink.cmp").hide()
	else
		-- 使用 stopinsert 命令更直接可靠,防止ctrl + [失效
		vim.cmd("stopinsert")
	end
end, { silent = true, noremap = true })

-- 使用 jk (手指自然摆放位置)
map("i", "jk", "<Esc>", { silent = true, noremap = true, desc = "Return to Normal Mode" })
-- map("v", "jk", "<Esc>", { silent = true, noremap = true, desc = "Return to Normal Mode" })

-- 弹出 LazyGit 控制台
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { silent = true, noremap = true, desc = "LazyGit" })

-- 如果你想查看当前文件的提交历史
map("n", "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", { silent = true, noremap = true, desc = "LazyGit Current File" })

local term = require("config.terminal")

-- 1. 全局切换终端 (使用 Alt + i 或者 <leader>t)
map({ "n", "t" }, "<A-i>", term.toggle_terminal, { silent = true, noremap = true, desc = "Toggle Floating Terminal" })

-- 2. 终端模式下的特殊映射
-- 在终端里按 jj 也能退回到 Normal 模式 (方便你复制终端里的报错信息)
map("t", "jk", [[<C-\><C-n>]], { silent = true, noremap = true, desc = "Exit Terminal Mode" })

-- 3. 快速关闭终端窗口 (在 Normal 模式下按 q)
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		-- 终端缓冲区不需要行号
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		-- 在该缓冲区定义 q 直接隐藏窗口
		map("n", "q", "<cmd>close<cr>", { buffer = true })
	end,
})

map("n", "<a-j>", "<cmd>m .+1<cr>==", { noremap = true, silent = true, desc = "Move line down" })
map("n", "<a-k>", "<cmd>m .-2<cr>==", { noremap = true, silent = true, desc = "Move line up" })
map("v", "<a-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

map("i", "<a-s>", "<c-o>:wq!<CR>", { noremap = true, silent = true, desc = "Force quit file" })
map(
	"n",
	"<leader>p",
	'"_diwP',
	{ noremap = true, silent = true, desc = "Delete current textobject patest content on there" }
)
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy content to system clipboard" })
map("v", "<leader>p", '"_dP', { noremap = true, silent = true, desc = "Delete selected text, patest content on there" })
map(
	"v",
	"<leader>P",
	'"_d"+P',
	{ noremap = true, silent = true, desc = "Delete selected text, patest content on there" }
)

local dap = require("dap")
local dapui = require("dapui")

-- 基础调试操作
map("n", "<F5>", dap.continue, { silent = true, noremap = true, desc = "Debug: Start/Continue" })
map("n", "<F8>", dap.step_over, { silent = true, noremap = true, desc = "Debug: Step Over" })
map("n", "<F7>", dap.step_into, { silent = true, noremap = true, desc = "Debug: Step Into" })
map("n", "<F10>", dap.step_out, { silent = true, noremap = true, desc = "Debug: Step Out" })

-- 断点与 UI
map("n", "<leader>db", dap.toggle_breakpoint, { silent = true, noremap = true, desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Breakpoint Condition" })
vim.keymap.set("n", "<F5>", function()
	dap.continue()
end)
-- 关闭调试
map("n", "<leader>dc", function()
	dap.terminate()
	dapui.close()
end)
-- toggle UI
map("n", "<leader>du", dapui.toggle)

-- 悬浮查看变量 (非常重要！)
map("n", "<leader>di", dapui.eval, { silent = true, noremap = true, desc = "Debug: Hover Variable" })

map({ "n" }, "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
