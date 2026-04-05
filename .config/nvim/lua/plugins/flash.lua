return {
	{ -- flash闪电移动
		"folke/flash.nvim", -- 闪电移动跳转
		event = "VeryLazy",
		---@type Flash.Config
		-- opts = { labels = "asdfghjklqwertyuiopzxcvbnm123456789" },
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
			{
				"gl",
				mode = { "n" },
				function()
					require("flash").jump(
					---@diagnostic disable-next-line: missing-fields
						{
							search = { mode = "search", max_length = 0 },
							label = { after = { 0, 0 } },
							pattern = "^",
						}
					)
				end,
				desc = "Flash: Jump to line start"
			},
			{
				"gl",
				mode = { "x", "o" },
				function()
					require("flash").jump(
					---@diagnostic disable-next-line: missing-fields
						{
							search = { mode = "search", max_length = 0 },
							pattern = "$",
						}
					)
				end,
				desc = "Flash: Jump to line end"
			},
		},
	},
}
