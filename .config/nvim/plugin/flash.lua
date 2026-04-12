vim.pack.add({
	"https://github.com/folke/flash.nvim",
})
require("flash").setup()
-- Flash: s
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump({
		search = { forward = true, wrap = false, multi_window = false },
	})
end, { desc = "Flash" })

-- Flash Treesitter: S
vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "<A-s>", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set({ "c" }, "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })
