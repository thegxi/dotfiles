return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- 获取 gruvbox 主题基础
      local custom_gruvbox = require("lualine.themes.gruvbox")
      
      -- 核心修复：强制中间栏 (c) 透明，消除圆角边缘的像素瑕疵
      -- "None" 或 nil 会让 lualine 不画背景，直接透出底层
      custom_gruvbox.normal.c.bg = "None"
      custom_gruvbox.insert.c.bg = "None"
      custom_gruvbox.visual.c.bg = "None"
      custom_gruvbox.replace.c.bg = "None"
      custom_gruvbox.command.c.bg = "None"
      custom_gruvbox.inactive.c.bg = "None"

      require("lualine").setup({
        options = {
          theme = custom_gruvbox,
          -- 使用 Gruvbox 风格的圆角分段
          component_separators = "", 
          globalstatus = true,
          icons_enabled = true,
        },
        sections = {
          lualine_a = {
            { 
              "mode", 
              fmt = function(str) return " " .. str end, -- 你的 Arch 标识
              padding = { right = 1 } 
            },
          },
          lualine_b = {
            { "filename", file_status = true, path = 1 }, -- path=1 显示相对路径
            "branch",
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
            },
          },
          lualine_x = {
            {
              -- 简单的 LSP 显示逻辑
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "No LSP" end
                return clients[1].name
              end,
              icon = " ",
              color = { fg = "#fabd2f", gui = "bold" }, -- 使用 Gruvbox 的黄色
            },
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = {
            { 
              "location", 
              padding = { left = 1 } 
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- 如果你不使用 snacks，建议配合 nvim-notify 来处理通知弹窗
      "rcarriga/nvim-notify", 
    },
    opts = {
      lsp = {
        -- 改善 LSP 信息在悬浮窗中的渲染
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- 核心：开启居中悬浮模式
      presets = {
        bottom_search = false,    -- 搜索栏 (/) 也悬浮
        command_palette = true,   -- 关键：将命令行移至屏幕中间
        long_message_to_split = true, 
        lsp_doc_border = true,    -- 给 LSP 帮助文档加上边框
      },
      -- 路由系统：拦截并屏蔽你之前看到的警告消息
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "lazyredraw" },
              { find = "set temporarily" },
              { find = "written" }, -- 顺便屏蔽文件保存成功的提示
            },
          },
          opts = { skip = true },
        },
      },
      -- UI 样式微调：确保符合你的圆角审美
      views = {
        cmdline_popup = {
          position = { row = "5%", col = "50%" },
          size = { width = 60, height = "auto" },
          border = {
            style = "rounded", -- 圆角边框
            padding = { 0, 1 },
          },
        },
        popupmenu = {
          relative = "editor",
          position = { row = "53%", col = "50%" }, -- 紧贴命令行下方
          size = { width = 60, height = 10 },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
          },
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "NoiceSearch", { fg = "#928374", italic = true })
      -- 如果使用了 nvim-notify，可以在这里初始化背景色
      require("notify").setup({
        background_colour = "#000000", -- 设置为黑色或透明
        render = "compact",
      })
      require("noice").setup(opts)
      vim.opt.lazyredraw = true 
    end,
  }
}
