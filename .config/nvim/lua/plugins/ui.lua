return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
		config = function()
			require("lualine").setup({
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return str:sub(1, 1)
							end,
						},
					},
					-- 状态栏c段显示navic代码导航信息，此处基于官方配置进行了改写
					lualine_c = {
						"filename",
						{ -- navic代码导航
							"navic",
							-- Component specific options
							color_correction = nil, -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
							-- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
							-- Setting it to "static" will perform a adjustment once when the component is being setup. This should
							--   be enough when the lualine section isn't changing colors based on the mode.
							-- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
							--   the current section.

							navic_opts = nil, -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
						},
					},
					lualine_x = { -- 去掉'fileformat'（目前只有windows、linux图标）
						{ -- 宏录制状态提示：recording @q
							function()
								local reg = vim.fn.reg_recording()
								if reg == "" then
									return ""
								end
								return "󰑊 Recording @" .. reg
							end,
							color = { fg = "#ff9e64" },
						},
						-- {
						-- 	function()
						-- 		-- Check if MCPHub is loaded
						-- 		if not vim.g.loaded_mcphub then
						-- 			return "󰐻 -"
						-- 		end
						--
						-- 		local count = vim.g.mcphub_servers_count or 0
						-- 		local status = vim.g.mcphub_status or "stopped"
						-- 		local executing = vim.g.mcphub_executing
						--
						-- 		-- Show "-" when stopped
						-- 		if status == "stopped" then
						-- 			return "󰐻 -"
						-- 		end
						--
						-- 		-- Show spinner when executing, starting, or restarting
						-- 		if executing or status == "starting" or status == "restarting" then
						-- 			local frames =
						-- 				{ "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
						-- 			local frame = math.floor(vim.loop.now() / 100) % #frames + 1
						-- 			return "󰐻 " .. frames[frame]
						-- 		end
						--
						-- 		return "󰐻 " .. count
						-- 	end,
						-- 	color = function()
						-- 		if not vim.g.loaded_mcphub then
						-- 			return { fg = "#6c7086" } -- Gray for not loaded
						-- 		end
						--
						-- 		local status = vim.g.mcphub_status or "stopped"
						-- 		if status == "ready" or status == "restarted" then
						-- 			return { fg = "#50fa7b" } -- Green for connected
						-- 		elseif status == "starting" or status == "restarting" then
						-- 			return { fg = "#ffb86c" } -- Orange for connecting
						-- 		else
						-- 			return { fg = "#ff5555" } -- Red for error/stopped
						-- 		end
						-- 	end,
						-- },
						"encoding",
						"filetype",
					},
				},
			})
		end,
	},
}
