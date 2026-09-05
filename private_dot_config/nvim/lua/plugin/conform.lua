require("conform").setup({
  formatters_by_ft = {
    lua = {
      "stylua",
    },

    rust = {
      "rustfmt",
    },

    c = {
      "clang_format",
    },

    cpp = {
      "clang_format",
    },

    java = {
      "google-java-format",
      lsp_format = "fallback",
    },

    sh = {
      "shfmt",
    },

    bash = {
      "shfmt",
    },

    fish = {
      "fish_indent",
    },
  },

  format_on_save = {
    timeout_ms = 1000,

    lsp_format = "fallback",
  },
})
