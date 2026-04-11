vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons", name = "mini.icons" },
	{ src = "https://github.com/ibhagwan/fzf-lua", name = "fzf-lua" },
})
local fzf = require("fzf-lua")
fzf.setup()
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Search over files" })
vim.keymap.set("n", "<leader>fg", fzf.git_files, { desc = "Search over git files" })
vim.keymap.set("n", "<leader>fc", fzf.live_grep_native, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "Resume fzf-lua" })
