local opt = vim.opt

-- =========================================
-- UI
-- =========================================
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 8

-- =========================================
-- Editor
-- =========================================
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true
opt.wrap = false
opt.textwidth = 120
opt.colorcolumn = "120"

-- =========================================
-- Search
-- =========================================
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- =========================================
-- Files
-- =========================================
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- =========================================
-- Completion
-- =========================================
opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
}
opt.pumheight = 10

-- =========================================
-- Split
-- =========================================
opt.splitbelow = true
opt.splitright = true

-- =========================================
-- Clipboard
-- =========================================
opt.clipboard = "unnamedplus"

-- =========================================
-- Folding
-- =========================================
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldenable = false

-- =========================================
-- Misc
-- =========================================
opt.mouse = "a"
opt.updatetime = 250
opt.timeoutlen = 500
opt.confirm = true
opt.virtualedit = "block"
-- ripgrep
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
-- Better command line
opt.inccommand = "split"
-- Completion preview
opt.pumblend = 10
