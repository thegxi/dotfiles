vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.keymap.set("i", "<CR>", function()
			local line = vim.api.nvim_get_current_line()

			-- 1. 去掉行末空格后的内容
			local trimmed_line = line:gsub("%s*$", "")

			-- 2. 如果是空行，直接回车
			if trimmed_line == "" then
				return "<CR>"
			end

			-- 3. 获取最后一个字符
			local last_char = trimmed_line:sub(-1)

			-- 4. 如果最后一个字符不是 ; { }，则补分号
			-- 也可以根据需要加上 ( ) 等排除项
			if not last_char:match("[;{}]") then
				return "<End>;<CR>"
			end

			return "<CR>"
		end, { expr = true, buffer = true })
	end,
})
