return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		opts = {
			close_if_last_window = true,
			popup_border_style = "rounded",

			enable_git_status = true,
			enable_diagnostics = true,
			sources = {
				"filesystem",
				-- "buffers",
				-- "git_status",
			},
			source_selector = {
				winbar = true,
				statusline = false,
			},
			filesystem = {
				-- 自定义根节点显示
				root_node = function(config, node, state)
					return {
						{ text = "  ", texthl = "NeoTreeDirectoryIcon" },
						{ text = vim.fn.fnamemodify(node.path, ":t"), texthl = "NeoTreeRootName" }, -- ":t" 只取最后一级目录名
					}
				end,
				hijack_netrw_behavior = "open_current",
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
				},

				use_libuv_file_watcher = true,
			},
			window = {
				position = "left",
				width = 32,
				mappings = {

					["<space>"] = "toggle_node",

					["<cr>"] = function(state)
						require("neo-tree.sources.filesystem.commands").open(state)
						require("neo-tree.command").execute({
							action = "close",
							source = "filesystem",
						})
					end,
					["l"] = "open",
					["h"] = "close_node",

					["a"] = {
						"add",
						config = {
							show_path = "relative",
						},
					},

					["d"] = "delete",
					["r"] = "rename",

					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",

					["c"] = "copy",

					["H"] = "toggle_hidden",

					["/"] = "fuzzy_finder",

					["q"] = "close_window",
					["v"] = "open_vsplit",
					["s"] = "open_split",
				},
			},
		},
	},
}
