require("bufferline").setup({
  options = {
    mode = "buffers",

    diagnostics = "nvim_lsp",

    separator_style = "slant",

    always_show_bufferline = true,

    show_buffer_close_icons = true,

    show_close_icon = true,

    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        separator = true,
      },
    },
  },
})
