return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text", -- 在代码行末显示变量值
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				-- 自动安装调试器：根据你的语言需求添加
				ensure_installed = { "python", "delve", "cpptools", "java-debug-adapter" },
				automatic_installation = true,
			})

			-- 1. Dap UI 圆角配置
			dapui.setup({
				floating = {
					border = "rounded", -- 你的圆角坚持
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.5 },
							{ id = "breakpoints", size = 0.2 },
							{ id = "stacks", size = 0.3 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = { { id = "repl", size = 1.0 } },
						position = "bottom",
						size = 10,
					},
				},
			})

			-- 2. 自动打开/关闭 UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- 3. 自定义断点图标 (匹配 Gruvbox)
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#fb4934" }) -- Gruvbox Red
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
	},
}
