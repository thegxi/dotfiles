-- basic options
require("config.options")
-- package manager
require("config.lazy")
require("config.keymap")

vim.lsp.enable("lua-language-server")
vim.lsp.enable("jdtls")
vim.lsp.enable("pyright")
vim.lsp.enable("gopls")
vim.lsp.enable("css-lsp")
vim.lsp.enable("html-lsp")
vim.lsp.enable("vtsls")
