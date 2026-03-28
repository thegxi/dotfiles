return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "上一个 Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "下一个 Buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "跳转到指定 Buffer" },
    { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "关闭指定 Buffer" },
  },
  opts = {
    options = {
      mode = "buffers", -- 使用 Buffer 模式而非 Tab 模式
      style_preset = "default",
      separator_style = "slant", -- 斜切风格，配合 Gruvbox 非常硬朗
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      sort_by = "insert_after_current",
      
      -- 基础 UI 调整
      show_buffer_close_icons = false,
      show_close_icon = false,
      indicator = {
        style = "underline", -- 当前选中的 Buffer 下方显示下划线
      },

      -- 诊断信息显示 (集成 LSP)
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return "(" .. icon .. count .. ")"
      end,

      -- 适配文件树 (如果你用了 nvim-tree 或 neo-tree)
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        },
      },
    },
  },
}
