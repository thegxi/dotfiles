local map = vim.keymap.set
local fzf = require("fzf-lua")
map("n", "<leader>ff", fzf.files, { desc = "Fzf Files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Fzf Grep" })
map("n", "<leader>fb", function()
	fzf.buffers()
end, { desc = "Fzf Buffers" })
map("n", "<leader>fht", fzf.help_tags, { desc = "Fzf Help" })
map("n", "<leader>fc", fzf.command_history, { desc = "Command History" })

map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "上一个 Buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "下一个 Buffer" })
map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "跳转到指定 Buffer" })
map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "关闭指定 Buffer" })
-- 纯原生关闭 Buffer 逻辑，不依赖任何第三方插件
map("n", "<leader>bd", function()
	local bufnr = vim.api.nvim_get_current_buf()
	-- 如果是最后一个 buffer，直接删掉可能会关掉窗口，这里可以做个判断
	vim.cmd("bdelete")
end, { desc = "Close Current Buffer" })

-- 快捷键：使用 <leader>e (Explorer)
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Explorer" })
-- 自动定位到当前文件
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find current file in Tree" })

-- 代码格式化
map("n", "<leader>fc", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- 移动优化：在开启了 wrap（折行）时，按 j/k 也是按视觉行移动
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 快速保存/退出 (既然用了 cmdheight=0，减少手动输入 :w 的频率)
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save Buffer" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit Window" })

-- 更好的缩进体验 (视觉模式下缩进后不会丢失选中状态)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- 剪贴板优化：x 不会覆盖你的寄存器，只删除不复制
map("n", "x", '"_x')

-- 跳转到定义 (也可以用 ctrl + ])
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Implementation" })

-- 悬浮文档 (按两次可以进入文档窗口进行复制)
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })

-- 变量重命名 (0.11+ 的 rename 默认在浮窗内，非常现代)
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- 代码操作 (快速修复错误)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- 诊断跳转 (左下角出现红点时快速跳转)
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
