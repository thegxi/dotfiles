return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	---@module 'which-key'
	---@type wk.Opts
	---@diagnostic disable-next-line: missing-fields
	opts = {
		delay = 0,
		disable = {
			ft = { "neo-tree", "neo-tree-popup", "alpha", "dashboard", "NvimTree" },
			bt = {},
		},
		sort = { "desc" },
		icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have_nerd_font,

			-- 自定义关键词图标
			rules = {
				{ pattern = "diag", icon = "󱖫 ", color = "green" },
				{ pattern = "doc", icon = " ", color = "orange" },
				{ pattern = "misc", icon = " ", color = "green" },
			},
		},

		-- Document existing key chains
		spec = {
			{ "<leader>a", group = "avante" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code", mode = { "n", "x" } },
			{ "<leader>d", group = "debug" },
			{ "<leader>s", group = "search" },
			{ "<leader>w", group = "workspace" },
			{ "<leader>e", group = "extract", mode = { "n", "v" } },
			{ "<leader>h", group = "hunk", mode = { "n", "v" } },
			{ "<leader>v", group = "venv" },
			{ "<leader>j", group = "jupyter" },
			{ "<leader>r", group = "rest", mode = { "n", "v" } },
			{ "<leader>m", group = "misc", mode = { "n", "v" } },
			{ "<leader>t", group = "test", mode = { "n", "v" } },
			-- { "<leader>h", group = "harpoon", mode = { "n", "v" } },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
