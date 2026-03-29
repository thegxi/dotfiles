local mason_path = vim.fn.stdpath("data") .. "/mason"

local jdtls_bin = mason_path .. "/packages/jdtls/bin/jdtls"

local function find_root()
	local root_files = {
		"gradlew",
		"mvnw",
		"pom.xml",
		"build.gradle",
		".git",
	}

	return vim.fs.root(0, root_files)
end

local function workspace_dir()
	local root = find_root()
	local project_name = vim.fn.fnamemodify(root, ":p:h:t")

	return vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name
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

	filetypes = { "java" },

	init_options = {
		bundles = bundles,
	},
}
