local fzf = require("fzf-lua")

fzf.setup({
  winopts = {
    height = 0.85,
    width = 0.85,
    preview = {
      default = "bat",
    },
  },

  files = {
    prompt = "Files> ",
  },

  grep = {
    prompt = "Grep> ",
  },
})
