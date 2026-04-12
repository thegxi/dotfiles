----------------------------------------------------------------
-- 使用内置包管理 vim.pack 安装 Treesitter
----------------------------------------------------------------
vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		version = "main",
	},
})

----------------------------------------------------------------
-- Treesitter 基础初始化
----------------------------------------------------------------
-- 初始化 Treesitter
-- Neovim 0.12 新 API
require("nvim-treesitter").setup({})

----------------------------------------------------------------
-- 安装语言解析器（parser）
----------------------------------------------------------------
-- install 会自动下载 parser
-- 如果 parser 已存在，则会检查更新
require("nvim-treesitter").install({

	-- shell
	"bash",
	"fish",

	-- C 系语言
	"c",

	-- Web
	"html",
	"css",
	"javascript",
	"typescript",
	"tsx",

	-- 配置文件
	"json",
	"yaml",
	"toml",
	"ini",

	-- Lua
	"lua",
	"luadoc",
	"luap",

	-- Markdown
	"markdown",
	"markdown_inline",

	-- Git
	"gitcommit",
	"gitignore",
	"diff",

	-- Go
	"go",
	"gomod",
	"gosum",
	"gowork",

	-- 其它
	"dockerfile",
	"sql",
	"regex",
	"query",
	"vim",
	"vimdoc",
	"xml",
	"nginx",
	"proto",
	"nix",
	"terraform",
	"zig",
	"rust",
	"python",
	"scss",
	"make",
	"jsdoc",
	"comment",
	"blade",
})

----------------------------------------------------------------
-- Textobjects（语法结构选择）
----------------------------------------------------------------
require("nvim-treesitter-textobjects").setup({

	------------------------------------------------------------
	-- 文本对象选择
	------------------------------------------------------------
	select = {

		enable = true,

		-- 自动向前查找最近的语法对象
		lookahead = true,

		-- 指定选择模式
		selection_modes = {

			-- 参数
			["@parameter.outer"] = "v",

			-- 函数
			["@function.outer"] = "V",

			-- 类
			["@class.outer"] = "<c-v>",
		},

		-- 选择时是否包含周围空格
		include_surrounding_whitespace = false,
	},

	------------------------------------------------------------
	-- 基于语法结构的跳转
	------------------------------------------------------------
	move = {

		enable = true,

		-- 跳转记录到 jumplist
		set_jumps = true,
	},
})

----------------------------------------------------------------
-- Textobject 选择快捷键
----------------------------------------------------------------
local sel = require("nvim-treesitter-textobjects.select")

for _, map in ipairs({

	-- 函数
	{ { "x", "o" }, "af", "@function.outer" },
	{ { "x", "o" }, "if", "@function.inner" },

	-- 类
	{ { "x", "o" }, "ac", "@class.outer" },
	{ { "x", "o" }, "ic", "@class.inner" },

	-- 参数
	{ { "x", "o" }, "aa", "@parameter.outer" },
	{ { "x", "o" }, "ia", "@parameter.inner" },

	-- 注释
	{ { "x", "o" }, "ad", "@comment.outer" },

	-- 语句
	{ { "x", "o" }, "as", "@statement.outer" },
}) do
	vim.keymap.set(map[1], map[2], function()
		sel.select_textobject(map[3], "textobjects")
	end, {
		desc = "Select " .. map[3],
	})
end

----------------------------------------------------------------
-- Textobject 跳转快捷键
----------------------------------------------------------------
local mv = require("nvim-treesitter-textobjects.move")

for _, map in ipairs({

	-- 函数
	{ { "n", "x", "o" }, "]m", mv.goto_next_start, "@function.outer" },
	{ { "n", "x", "o" }, "[m", mv.goto_previous_start, "@function.outer" },

	-- 类
	{ { "n", "x", "o" }, "]]", mv.goto_next_start, "@class.outer" },
	{ { "n", "x", "o" }, "[[", mv.goto_previous_start, "@class.outer" },

	-- 函数结束
	{ { "n", "x", "o" }, "]M", mv.goto_next_end, "@function.outer" },
	{ { "n", "x", "o" }, "[M", mv.goto_previous_end, "@function.outer" },

	-- 循环
	{
		{ "n", "x", "o" },
		"]o",
		mv.goto_next_start,
		{ "@loop.inner", "@loop.outer" },
	},

	{
		{ "n", "x", "o" },
		"[o",
		mv.goto_previous_start,
		{ "@loop.inner", "@loop.outer" },
	},
}) do
	local modes, lhs, fn, query = map[1], map[2], map[3], map[4]

	local qstr = (type(query) == "table") and table.concat(query, ",") or query

	vim.keymap.set(modes, lhs, function()
		fn(query, "textobjects")
	end, {
		desc = "Move to " .. qstr,
	})
end

----------------------------------------------------------------
-- 自动更新 parser
----------------------------------------------------------------
vim.api.nvim_create_autocmd("PackChanged", {

	desc = "Update treesitter parser",

	group = vim.api.nvim_create_augroup("treesitter_auto_update", { clear = true }),

	callback = function(event)
		if event.data.kind == "update" then
			local ok = pcall(vim.cmd, "TSUpdate")

			if ok then
				vim.notify("Treesitter parser updated", vim.log.levels.INFO)
			end
		end
	end,
})

----------------------------------------------------------------
-- 不启用 Treesitter 的 buffer 类型
-- 提升性能并避免异常
----------------------------------------------------------------
local SKIP_FT = {

	[""] = true,

	-- 帮助类
	qf = true,
	help = true,
	man = true,

	-- UI类
	notify = true,
	noice = true,

	-- fzf-lua
	fzf = true,
	["fzf-lua"] = true,
	FzfLua = true,

	-- 调试窗口
	dapui_scopes = true,
	dapui_breakpoints = true,
	dapui_stacks = true,
	dapui_watches = true,
	dapui_console = true,
	dap_repl = true,

	-- git
	gitcommit = true,
	gitrebase = true,

	-- 系统窗口
	lspinfo = true,
	checkhealth = true,
	startuptime = true,

	-- 其它插件 UI
	spectre_panel = true,
	["grug-far"] = true,
	trouble = true,

	-- 插件管理器
	lazy = true,
}

----------------------------------------------------------------
-- 打开文件时自动启动 Treesitter
----------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {

	pattern = "*",

	callback = function()
		local ft = vim.bo.filetype

		-- 跳过不需要的 buffer
		if SKIP_FT[ft] then
			return
		end

		-- 启动 treesitter
		local ok = pcall(vim.treesitter.start)

		if not ok then
			return
		end

		--------------------------------------------------------
		-- 启用基于语法树的折叠
		--------------------------------------------------------
		vim.wo.foldmethod = "expr"

		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

----------------------------------------------------------------
-- 使用 Treesitter 缩进规则
----------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {

	callback = function()
		if SKIP_FT[vim.bo.filetype] then
			return
		end

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
