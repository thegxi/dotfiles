-- =========================================
-- Diagnostics
-- =========================================
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },

  signs = true,

  underline = true,

  update_in_insert = false,

  severity_sort = true,

  float = {
    border = "rounded",
    source = "if_many",
  },
})

-- =========================================
-- LSP Attach
-- =========================================
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup(
    "UserLspAttach",
    {
      clear = true,
    }
  ),

  callback = function(args)
    local client = vim.lsp.get_client_by_id(
      args.data.client_id
    )

    if not client then
      return
    end

    local bufnr = args.buf

    -- Inlay hints
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, {
        bufnr = bufnr,
      })
    end

    -- Document highlight
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({
        "CursorHold",
        "CursorHoldI",
      }, {
        buffer = bufnr,

        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })

      vim.api.nvim_create_autocmd({
        "CursorMoved",
        "CursorMovedI",
      }, {
        buffer = bufnr,

        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end
  end,
})

-- =========================================
-- Enable LSP
-- =========================================
vim.lsp.enable({
  "bashls",
  "fish_lsp",
  "clangd",
  "rust_analyzer",
  "lua_ls"
})
