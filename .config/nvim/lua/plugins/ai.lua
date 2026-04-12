require("codecompanion").setup({
	opts = {
		log_level = "DEBUG", -- or "TRACE"
	},
})

-- 在 setup 函数之后添加
vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI 聊天" })
vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "AI 行内指令" })
vim.keymap.set("v", "<leader>ae", "<cmd>CodeCompanion /explain<cr>", { desc = "解释代码" })

-- 扩展：将选中的代码放入聊天框
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "将代码加入 AI 上下文" })
