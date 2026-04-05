local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_bin = mason_path .. "/packages/jdtls/bin/jdtls"

local function find_root()
	local root_files = {
		"settings.gradle.kts", -- 多模块项目的真正根标志
		"gradlew",
		"build.gradle.kts",
		".git",
	}
	return vim.fs.root(0, root_files)
end

local function workspace_dir()
	-- 获取当前 buffer 的路径，而不是 getcwd()
	local buf_name = vim.api.nvim_buf_get_name(0)
	local root_files = { "settings.gradle.kts", "gradlew", "build.gradle.kts", ".git" }
	local root = vim.fs.find(root_files, { upward = true, path = buf_name })[1]

	-- 提取项目名
	root = root and vim.fn.fnamemodify(root, ":h") or vim.fn.getcwd()
	local project_name = vim.fn.fnamemodify(root, ":p:h:t")

	local path = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name
	if vim.fn.isdirectory(path) == 0 then
		vim.fn.mkdir(path, "p")
	end
	return path
end

-- debug bundle
local bundles = {}

local java_debug_path = mason_path
	.. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"

vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path), "\n"))

return {
	cmd = {
		jdtls_bin,
		"-data",
		workspace_dir(),
	},

	root_dir = find_root(),

	-- filetypes = { "java" },

	init_options = {
		bundles = bundles,
	},
	settings = {
		java = {
			import = { gradle = { enabled = true } },
			configuration = { updateBuildConfiguration = "interactive" },
			completion = {
				-- 允许在未 import 的情况下补全静态成员（如 IdType.AUTO）
				favoriteStaticMembers = {
					"com.baomidou.mybatisplus.annotation.IdType.*",
					"com.baomidou.mybatisplus.annotation.FieldFill.*",
					"org.junit.jupiter.api.Assertions.*",
				},
				-- 开启全量补全支持
				guessMethodArguments = true,
			},
			-- 确保 contentProvider 开启，解决 Invalid completion proposal
			contentProvider = { preferred = "fernflower" },
		},
	},
}
