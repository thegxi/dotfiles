vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ========================================
-- Core configuration
-- ========================================
require("config.option")
require("config.keymap")
require("config.autocmd")
require("config.lsp")

-- ========================================
-- Native plugin manager
-- ========================================
require("plugin")
