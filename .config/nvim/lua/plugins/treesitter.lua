local treesitter = require("nvim-treesitter")
treesitter.setup({})
treesitter.install({
	"rust",
	"javascript",
	"c",
	"cpp",
	"lua",
})
