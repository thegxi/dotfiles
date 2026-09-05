local map = vim.keymap.set

-- =========================================
-- General
-- =========================================
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<cmd>write<CR>", {
  desc = "Write",
})
map("n", "<leader>q", "<cmd>quit<CR>", {
  desc = "Quit",
})
map("n", "<leader>x", "<cmd>bdelete<CR>", {
  desc = "Delete buffer",
})

-- =========================================
-- Window
-- =========================================
map("n", "<C-h>", "<C-w>h", {
  desc = "Window left",
})
map("n", "<C-j>", "<C-w>j", {
  desc = "Window down",
})
map("n", "<C-k>", "<C-w>k", {
  desc = "Window up",
})
map("n", "<C-l>", "<C-w>l", {
  desc = "Window right",
})
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- =========================================
-- Buffer
-- =========================================
map("n", "<S-h>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})
map("n", "<S-l>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

-- =========================================
-- Format
-- =========================================
map({ "n", "v" }, "<leader>f", function()
  require("conform").format({
    async = true,
    lsp_format = "fallback",
  })
end, {
  desc = "Format",
})

-- =========================================
-- Diagnostics
-- =========================================
map("n", "<leader>d", vim.diagnostic.open_float, {
  desc = "Diagnostic",
})
map("n", "[d", vim.diagnostic.goto_prev, {
  desc = "Previous diagnostic",
})
map("n", "]d", vim.diagnostic.goto_next, {
  desc = "Next diagnostic",
})
map("n", "<leader>dl", vim.diagnostic.setloclist, {
  desc = "Diagnostic list",
})

-- =========================================
-- LSP
-- =========================================
map("n", "gd", vim.lsp.buf.definition, {
  desc = "Go to definition",
})
map("n", "gD", vim.lsp.buf.declaration, {
  desc = "Go to declaration",
})
map("n", "gr", vim.lsp.buf.references, {
  desc = "References",
})
map("n", "gi", vim.lsp.buf.implementation, {
  desc = "Implementation",
})
map("n", "K", vim.lsp.buf.hover, {
  desc = "Hover",
})
map("n", "<leader>rn", vim.lsp.buf.rename, {
  desc = "Rename",
})
map("n", "<leader>ca", vim.lsp.buf.code_action, {
  desc = "Code action",
})
map("n", "<leader>ds", vim.lsp.buf.document_symbol, {
  desc = "Document symbols",
})
map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, {
  desc = "Workspace symbols",
})
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(
    not vim.lsp.inlay_hint.is_enabled()
  )
end, {
  desc = "Toggle inlay hints",
})

map("n", "<leader>ff", "<cmd>FzfLua files<CR>", {
  desc = "Find files",
})

map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", {
  desc = "Live grep",
})

map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", {
  desc = "Buffers",
})

map("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", {
  desc = "Help",
})

map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", {
  desc = "Recent files",
})

map("n", "<leader>f", "", {
  desc = "Find",
})

map("n", "<leader>l", "", {
  desc = "LSP",
})

map("n", "<leader>g", "", {
  desc = "Git",
})

map("n", "<leader>b", "", {
  desc = "Buffer",
})

map("n", "<leader>gg", "<cmd>LazyGit<CR>", {
  desc = "LazyGit",
})
