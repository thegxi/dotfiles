local dap = require("dap")

dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Debug current file",
		mainClass = function()
			return vim.fn.expand("%:p")
		end,
	},
}
