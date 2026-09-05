-- ~/.config/nvim/lua/plugins/init.lua

local M = {}

M.plugins_list = {
  -- =========================================
  -- Editor
  -- =========================================
  editor = {
    {
      src = "https://github.com/Saghen/blink.cmp",
      version = vim.version.range("1.*"),
    },

    {
      src = "https://github.com/windwp/nvim-autopairs",
    },

    {
      src = "https://github.com/kylechui/nvim-surround",
      version = vim.version.range("4.x"),
    },
  },

  -- =========================================
  -- LSP / Formatter
  -- =========================================
  lsp = {
    {
      src = "https://github.com/mason-org/mason.nvim",
    },

    {
      src = "https://github.com/stevearc/conform.nvim",
    },
  },

  -- =========================================
  -- UI
  -- =========================================
  ui = {
    {
      src = "https://github.com/catppuccin/nvim",
    },

    {
      src = "https://github.com/folke/tokyonight.nvim",
    },

    {
      src = "https://github.com/nvim-tree/nvim-web-devicons",
    },

    {
      src = "https://github.com/akinsho/bufferline.nvim",
    },
  },

  -- =========================================
  -- Navigation
  -- =========================================
  navigation = {
    {
      src = "https://github.com/ibhagwan/fzf-lua",
    },

    {
      src = "https://github.com/folke/flash.nvim",
    },

    {
      src = "https://github.com/DrKJeff16/project.nvim",
    },
  },

  -- =========================================
  -- Coding
  -- =========================================
  coding = {
    {
      src = "https://github.com/HiPhish/rainbow-delimiters.nvim",
    },

    {
      src = "https://github.com/folke/which-key.nvim",
    },
  },

  -- =========================================
  -- Git
  -- =========================================
  git = {
    {
      src = "https://github.com/kdheepak/lazygit.nvim",
    },
  },

  -- =========================================
  -- AI
  -- =========================================
  ai = {
    {
      src = "https://github.com/olimorris/codecompanion.nvim",
    },

    {
      src = "https://github.com/nvim-lua/plenary.nvim",
    },
  },

  -- =========================================
  -- Syntax
  -- =========================================
  syntax = {
    {
      src = "https://github.com/nvim-treesitter/nvim-treesitter",
    },
  },
}

-- =========================================
-- Flatten
-- =========================================
local install_list = {}

for _, group in pairs(M.plugins_list) do
  vim.list_extend(install_list, group)
end

-- =========================================
-- Native package manager
-- =========================================
vim.pack.add(install_list)

-- =========================================
-- Loaded plugin setup
-- =========================================
local plugin_dir = vim.fn.stdpath("config")
  .. "/lua/plugin"

local files = vim.fn.glob(
  plugin_dir .. "/*.lua",
  false,
  true
)

for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r")

  if name ~= "init" then
    require("plugin." .. name)
  end
end

return M
