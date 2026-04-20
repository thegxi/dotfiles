local snacks = require("snacks")

snacks.setup({
	animate = { enabled = true },
	bigfile = {
		enabled = true
	},
	dashboard = { enabled = false },
	explorer = { enabled = true, replace_netrw = true },
	indent = { enabled = true },
	input = { enabled = true },
  notifier = { enabled = true },
  picker = { enable = true },
  quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	terminal = { enabled = true },
	words = { enabled = false }
})

local map = vim.keymap.set

-- ======================
-- 🔍 Picker / Finder
-- ======================
map("n", "<leader><space>", function()
	snacks.picker.smart()
end, { desc = "Smart Find Files" })
map("n", "<leader>/", function()
	snacks.picker.grep()
end, { desc = "Grep" })
map("n", "<leader>:", function()
	snacks.picker.command_history()
end, { desc = "Command History" })
map("n", "<leader>n", function()
	snacks.notifier.show_history()
end, { desc = "Notification History" })
map("n", "<leader>e", function()
	snacks.explorer()
end, { desc = "Explorer" })

-- buffers
map("n", "<leader>,", function()
	snacks.picker.buffers({
		win = {
			input = {
				keys = {
					["dd"] = "bufdelete",
					["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
				},
			},
			list = { keys = { ["dd"] = "bufdelete" } },
		},
	})
end, { desc = "Buffers" })

map("n", "<leader>fb", function()
	snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>ff", function()
	snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
	snacks.picker.git_files()
end, { desc = "Git Files" })
map("n", "<leader>fp", function()
	snacks.picker.projects()
end, { desc = "Projects" })
map("n", "<leader>fr", function()
	snacks.picker.recent()
end, { desc = "Recent" })
map("n", "<leader>fc", function()
	snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config" })

-- search
map("n", "<leader>sb", function()
	snacks.picker.lines()
end, { desc = "Buffer Lines" })
map("n", "<leader>sg", function()
	snacks.picker.grep()
end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function()
	snacks.picker.grep_word()
end, { desc = "Grep Word" })

-- ======================
-- 🌱 Git
-- ======================
map("n", "<leader>gb", function()
	snacks.picker.git_branches()
end, { desc = "Git Branches" })
map("n", "<leader>gl", function()
	snacks.picker.git_log()
end, { desc = "Git Log" })
map("n", "<leader>gs", function()
	snacks.picker.git_status()
end, { desc = "Git Status" })
map("n", "<leader>gS", function()
	snacks.picker.git_stash()
end, { desc = "Git Stash" })
map("n", "<leader>gp", function()
	snacks.picker.git_diff()
end, { desc = "Git Diff" })
map("n", "<leader>gP", function()
	snacks.picker.git_diff({ base = "origin" })
end, { desc = "Git Diff Origin" })
map("n", "<leader>gf", function()
	snacks.picker.git_log_file()
end, { desc = "Git Log File" })

-- ======================
-- 🧠 LSP
-- ======================
map("n", "gd", function()
	snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
map("n", "gD", function()
	snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
map("n", "gR", function()
	snacks.picker.lsp_references()
end, { desc = "References" })
map("n", "gI", function()
	snacks.picker.lsp_implementations()
end, { desc = "Implementation" })
map("n", "gy", function()
	snacks.picker.lsp_type_definitions()
end, { desc = "Type Definition" })

map("n", "<leader>ss", function()
	snacks.picker.lsp_symbols()
end, { desc = "Symbols" })
map("n", "<leader>sS", function()
	snacks.picker.lsp_workspace_symbols()
end, { desc = "Workspace Symbols" })

-- ======================
-- 📦 Buffer
-- ======================
map("n", "<leader>bd", function()
	snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
	snacks.bufdelete.other()
end, { desc = "Delete Others" })

-- ======================
-- 🖥️ Terminal（重点修复版）
-- ======================
map("n", "<leader>fT", function()
	snacks.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<c-:>", function()
	snacks.terminal(nil, { cwd = vim.fn.getcwd() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-/>", function()
	snacks.terminal()
end, { desc = "Toggle Terminal" })
map("n", "<c-_>", function()
	snacks.terminal(nil, { cwd = vim.fn.getcwd() })
end, { desc = "which_key_ignore" })

-- ======================
-- 🎯 Other
-- ======================
map("n", "<leader>z", function()
	snacks.zen()
end, { desc = "Zen Mode" })
map("n", "<leader>Z", function()
	snacks.zen.zoom()
end, { desc = "Zoom" })

map("n", "<leader>.", function()
	snacks.scratch()
end, { desc = "Scratch" })
map("n", "<leader>S", function()
	snacks.scratch.select()
end, { desc = "Scratch Select" })

map("n", "<leader>gg", function()
	snacks.lazygit()
end, { desc = "Lazygit" })

map({ "n", "t" }, "]]", function()
	snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })

map({ "n", "t" }, "[[", function()
	snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })
