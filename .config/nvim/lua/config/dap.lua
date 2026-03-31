local dap = require("dap")
local mason_path = vim.fn.stdpath("data") .. "/mason"

-- java
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

-- clangd
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- 自动适配 Mason 安装路径
		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			-- 动态发动：让你选择要调试的可执行文件
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		-- 如果需要输入参数，取消注释下面这行
		-- args = function() return vim.split(vim.fn.input("Args: "), " ") end,
	},
}
-- 让 C 和 Rust 复用 C++ 的配置
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- python
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		local port = (config.connect or config).port
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = { source_filetype = "python" },
		})
	else
		cb({
			type = "executable",
			command = mason_path .. "/packages/debugpy/venv/bin/python", -- Mason 安装的路径
			args = { "-m", "debugpy.adapter" },
			options = { source_filetype = "python" },
		})
	end
end
dap.configurations.python = {
	{
		-- 调试当前激活的文件
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			-- 动态发动：自动识别当前环境的 python 路径
			local venv = vim.env.VIRTUAL_ENV
			if venv then
				return venv .. "/bin/python"
			end
			return "/usr/bin/python" -- Arch 默认路径
		end,
	},
	{
		-- 附加到正在运行的远程进程 (常用于 Django/Flask)
		type = "python",
		request = "attach",
		name = "Attach remote",
		connect = function()
			local host = vim.fn.input("Host [127.0.0.1]: ")
			host = host ~= "" and host or "127.0.0.1"
			local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
			return { host = host, port = port }
		end,
	},
}

-- go
dap.adapters.go = function(callback, config)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local port = 38697
	local opts = {
		args = { "dap", "-l", "127.0.0.1:" .. port },
		stdio = { nil, stdout },
	}

	-- 启动 dlv 进程
	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print("delve exited with exit code", code)
		end
	end)

	assert(handle, "Error running dlv: " .. tostring(pid_or_err))

	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)

	-- 等待 dlv 启动
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)
end

-- 定义调试配置 (Configurations)
dap.configurations.go = {
	{
		type = "go",
		name = "Debug (Main)",
		request = "launch",
		program = "${file}", -- 调试当前文件所在的包
	},
	{
		type = "go",
		name = "Debug (Package)",
		request = "launch",
		program = "./${relativeFileDirname}", -- 调试当前包
	},
	{
		type = "go",
		name = "Debug Test",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}", -- 调试当前包下的测试
	},
}
