return {
	-- "p00f/nvim-ts-rainbow", -- 配合treesitter，不同括号颜色区分
	{
		"HiPhish/rainbow-delimiters.nvim",
		submodules = false, -- 解决安装报错test/bin无法clone
		config = function()
			require("rainbow-delimiters.setup").setup({})
		end,
	},
}
