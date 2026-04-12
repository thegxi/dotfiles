vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.keymap.set("i", "<CR>", function()
			local line = vim.api.nvim_get_current_line()

			-- 如果行末不是 ; 或 { 或 }
			if line:match("[^;{}]%s*$") then
				return "<End>;<CR>"
			end

			return "<CR>"
		end, { expr = true, buffer = true })
	end,
})
