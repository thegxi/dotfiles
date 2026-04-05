return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lualine = require("lualine")

			-- 获取 gruvbox-material 主题
			local gruvbox_material = require("lualine.themes.tokyonight-storm")

			-- 模式颜色映射
			local mode_colors = {
				n = gruvbox_material.normal.a.bg,
				i = gruvbox_material.insert.a.bg,
				v = gruvbox_material.visual.a.bg,
				V = gruvbox_material.visual.a.bg,
				c = gruvbox_material.command.a.bg,
				s = gruvbox_material.visual.a.bg,
				R = gruvbox_material.replace.a.bg,
				t = gruvbox_material.insert.a.bg,
			}

			local function get_mode_color()
				return mode_colors[vim.fn.mode()] or gruvbox_material.normal.a.bg
			end

			-- 获取模式简写
			local function mode()
				local map = {
					n = "N",
					i = "I",
					v = "V",
					V = "V",
					c = "C",
					s = "S",
					R = "R",
					t = "T",
				}
				return map[vim.fn.mode()] or "[?]"
			end

			-- 检查窗口宽度
			local function hide_in_width()
				return vim.fn.winwidth(0) > 80
			end

			-- LSP 状态
			local function lsp_status()
				local msg = "No LSP"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name:sub(1, 2)
					end
				end
				return msg
			end

			-- Git 分支格式化
			local function git_branch()
				local branch = vim.b.gitsigns_head or vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
				if not branch or branch == "" then
					return "No Repo"
				end
				local segments = {}
				for seg in branch:gmatch("[^/]+") do
					table.insert(segments, seg)
				end
				for i = 1, #segments - 1 do
					segments[i] = segments[i]:sub(1, 1)
				end
				if #segments == 1 then
					return segments[1]
				end
				segments[1] = segments[1]:upper()
				for i = 2, #segments - 1 do
					segments[i] = segments[i]:lower()
				end
				return table.concat(segments, "", 1, #segments - 1) .. "›" .. segments[#segments]
			end

			-- 插入图标集合
			local icons = { "★", "☆", "✧", "✦", "❤", "♥", "♡", "⚡", "☯", "☢", "☠" }
			local function random_icon()
				return icons[math.random(#icons)]
			end
			math.randomseed(os.time())

			-- 左侧组件
			local left = {
				{
					mode,
					color = { fg = gruvbox_material.normal.a.fg, bg = get_mode_color(), gui = "bold" },
					padding = { left = 1, right = 1 },
				},
				{ "filename", path = 1, color = { fg = gruvbox_material.normal.b.fg, gui = "bold" } },
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					end,
					icon = "",
					color = { fg = gruvbox_material.normal.b.fg, gui = "bold" },
					cond = hide_in_width,
				},
				{ "searchcount", color = { fg = gruvbox_material.visual.a.bg, gui = "bold" }, cond = hide_in_width },
				{
					function()
						return random_icon()
					end,
					color = { fg = gruvbox_material.insert.a.bg },
					cond = hide_in_width,
				},
			}

			-- 右侧组件
			local right = {
				{
					function()
						local reg = vim.fn.reg_recording()
						return reg ~= "" and "[" .. reg .. "]" or ""
					end,
					color = { fg = gruvbox_material.command.a.bg, gui = "bold" },
					cond = function()
						return vim.fn.reg_recording() ~= ""
					end,
				},
				{
					function()
						return random_icon()
					end,
					color = { fg = gruvbox_material.visual.a.bg },
					cond = hide_in_width,
				},
				{
					lsp_status,
					icon = " ",
					color = { fg = gruvbox_material.insert.a.bg, gui = "bold" },
					cond = hide_in_width,
				},
				{
					git_branch,
					icon = " ",
					color = { fg = gruvbox_material.normal.a.bg, gui = "bold" },
					cond = hide_in_width,
				},
				{ "location", color = { fg = gruvbox_material.normal.a.fg, gui = "bold" } },
				{ "progress", color = { fg = gruvbox_material.visual.a.bg, gui = "bold" } },
			}

			-- 最终配置
			lualine.setup({
				options = {
					theme = gruvbox_material,
					component_separators = "",
					section_separators = "",
					globalstatus = true,
					disabled_filetypes = { "neo-tree", "undotree", "diff" },
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = left,
					lualine_x = right,
					lualine_y = {},
					lualine_z = {},
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
}
