-- 0.11.6 胶水代码
local servers = { "lua_ls", "pyright", "gopls", "jdtls" }
local capabilities = require('blink.cmp').get_lsp_capabilities()

for _, name in ipairs(servers) do
  local config = require('lsp.' .. name) -- 读取你分离的文件
  
  -- 注入通用的能力（如 blink.cmp 的补全支持）
  config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})

  -- 1. 注册配置
  vim.lsp.config(name, config)
  
  -- 2. 启用配置 (Neovim 会根据 config.filetypes 自动按需启动)
  vim.lsp.enable(name)
end
