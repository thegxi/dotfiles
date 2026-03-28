return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- 确保主题插件最先加载
    config = function()
      -- 基础配置：可以根据喜好调整对比度 (hard, medium, soft)
      require("gruvbox").setup({
        terminal_colors = true, -- 复制主题颜色到内置 terminal
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- 翻转部分高亮颜色
        contrast = "hard", -- 建议选择 hard，看起来更清晰干练
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      -- 应用主题
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
