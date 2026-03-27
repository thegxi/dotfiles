vim.g.mapleader = " "
require("config.options")
require("config.lazy")
require("config.keymap")
require("config.lsp")

vim.lsp.enable ("lua_ls")
vim.lsp.enable ("html")
vim.lsp.enable ("jdtls")
vim.lsp.enable ("pyright")

vim.g.db_adapter_shell="/bin/bash"
vim.g.dbs = {
  { name = 'dev', url = 'postgres://postgres:mypassword@localhost:5432/my-dev-db' },
  { name = 'staging', url = 'postgres://postgres:mypassword@localhost:5432/my-staging-db' },
  { name = 'wp', url = 'mysql://root@localhost/study' },
  {
    name = 'production',
    url = function()
      return 'mysql://root@localhost/study'
    end
  },
}
