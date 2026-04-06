return {
	{
		"wasabeef/bufferin.nvim",
		cmd = { "Bufferin" },
		config = function()
			require("bufferin").setup()
		end,
	},
}
