vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = "v1", name = "blink" },
})

require("blink.cmp").setup({
			keymap = {
				preset = "none", -- 禁用预设
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<CR>"] = { "accept", "fallback" },
				-- 针对 Java 这种冗长类名的处理：使用 Tab 快速循环
				["<Tab>"] = {
					function(cmp)
						if cmp.is_visible() then
							return cmp.select_next()
						end
						if cmp.snippet_active() then
							return cmp.snippet_forward()
						end
					end,
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						if cmp.is_visible() then
							return cmp.select_prev()
						end
						if cmp.snippet_active() then
							return cmp.snippet_backward()
						end
					end,
					"fallback",
				},
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Function = "󰊕",
					Variable = "󰫧",
				},
			},
			completion = {
				-- 文档预览窗口
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded", winblend = 0 },
				},

				list = { selection = { preselect = true, auto_insert = false } },
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" }, -- 显示来源 (LSP/Snippet/Buffer)
						},
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									return ctx.kind_icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									return ctx.kind_hl
								end,
							},
							label = {
								width = { fill = true, max = 60 },
								text = function(ctx)
									return ctx.label .. ctx.label_detail
								end,
								highlight = function(ctx)
									-- 实现类似 IntelliJ 的模糊匹配高亮
									local highlights = {
										{
											0,
											#ctx.label,
											group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
										},
									}
									if ctx.label_matched_indices ~= nil then
										for _, idx in ipairs(ctx.label_matched_indices) do
											table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
										end
									end
									return highlights
								end,
							},
							source_name = {
								width = { max = 10 },
								text = function(ctx)
									return "[" .. ctx.source_name:sub(1, 3):upper() .. "]"
								end,
								highlight = "BlinkCmpSource",
							},
						},
						treesitter = { "lsp" },
					},
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				},
			},
			-- 签名提示 (Signature)
			signature = {
				enabled = true,
				window = { border = "rounded", winblend = 0 },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					codecompanion = { "codecompanion" },
					-- sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						score_offset = 100,
						-- 核心：过滤掉不想要的 LSP 建议（可选）
						-- transform_items = function(_, items)
						-- 	-- 示例：过滤掉 Java 中一些极其少用的内部类
						-- return vim.tbl_filter(function(item)
						-- return not string.find(item.label, "%$%d")
						-- end, items)
						-- end,
					},
					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						score_offset = 80,
						opts = {
							friendly_snippets = true,
							search_paths = { vim.fn.stdpath("config") .. "/snippets" }, -- 自定义代码片段路径
						},
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 3,
					},
				},
			},
			snippets = { preset = "default" },
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				-- 接近 FZF 的排序逻辑
				frecency = {
					enabled = true,
					path = vim.fn.stdpath("state") .. "/blink/cmp/frecency.dat",
				},
				use_proximity = true,
			},
  })
