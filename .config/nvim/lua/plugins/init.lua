-- require("3rdlibs.lazy")
vim.pack.add({
	"https://github.com/edeneast/nightfox.nvim",
  "https://github.com/sainnhe/gruvbox-material",
  "https://github.com/uhs-robert/oasis.nvim",
  "https://github.com/folke/tokyonight.nvim",

	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/folke/which-key.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1" },
	{ src = "https://github.com/neovim/nvim-lspconfig", version = "v2.7.0" },
	{ src = "https://github.com/folke/snacks.nvim", version = "v2.31.0" },
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "v0.17.0" },
	{ src = "https://github.com/mason-org/mason.nvim", version = "v2.2.1" },

	{ src = "https://github.com/mfussenegger/nvim-dap", version = "0.10.0" },
	{ src = "https://github.com/nvim-neotest/nvim-nio", version = "v1.10.1" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui", version = "v4.0.0" },
	{ src = "https://github.com/olimorris/codecompanion.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

-- require("nightfox").setup({})
require("tokyonight").setup({})

vim.o.background = "dark"
vim.cmd.colorscheme("tokyonight-storm")

require("plugins.treesitter")
require("plugins.status_line")
require("plugins.blink")
require("plugins.conform")
require("plugins.lsp")
require("plugins.snacks")
require("plugins.mason")
require("plugins.mini")
require("plugins.dap")
require("plugins.which_key")
require("plugins.ai")
require("plugins.packui")
