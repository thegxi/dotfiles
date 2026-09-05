require("catppuccin").setup({
  flavour = "mocha",

  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
    },

    bufferline = true,
    fzf = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
