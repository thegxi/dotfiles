local ts = require("nvim-treesitter")

ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

ts.install({
  "bash",
  "fish",

  "c",
  "cpp",

  "java",
  "rust",
  "lua",

  "vim",
  "vimdoc",
  "query",

  "markdown",
  "markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "bash",
    "fish",

    "c",
    "cpp",

    "java",
    "rust",
    "lua",

    "vim",
    "markdown",
  },

  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})
