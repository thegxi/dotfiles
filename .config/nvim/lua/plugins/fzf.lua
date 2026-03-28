return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- 适配你的圆角审美
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35, -- 稍微靠上，避开中间
        preview = {
          layout = "vertical", -- 垂直布局在 Niri 这种纵向空间充足的环境下很好用
        },
        border = "rounded", -- 又是你最爱的圆角
      },
      fzf_opts = {
        ["--layout"] = "reverse",
      },
    },
  }
}
