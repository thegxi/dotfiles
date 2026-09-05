require("blink.cmp").setup({
  keymap = {
    preset = "default",
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 300,
    },

    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },

    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
  },

  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },

  snippets = {
    preset = "default",
  },

  signature = {
    enabled = true,
  },
})
