-- basic options
require("config.options")
-- package manager
require("config.lazy")
require("config.terminal")
require("config.keymap")
require("config.dap-java")

vim.lsp.enable("lua_ls")
vim.lsp.enable("jdtls")
vim.lsp.enable("pyright")
vim.lsp.enable("gopls")
vim.lsp.enable("css-lsp")
vim.lsp.enable("html-lsp")
vim.lsp.enable("vtsls")
vim.lsp.enable("ts_ls")
