return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "asm_lsp",
          "bashls",
          "clangd",
          "ts_ls",
          "glsl_analyzer",
          "marksman"
        }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local cmp_cap = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config("lua_ls", { capabilities = cmp_cap })
      vim.lsp.config("rust_analyzer", { capabilities = cmp_cap })
      vim.lsp.config("asm_lsp", { capabilities = cmp_cap })
      vim.lsp.config("bashls", { capabilities = cmp_cap })
      vim.lsp.config("clangd", { capabilities = cmp_cap })
      vim.lsp.config("ts_ls", { capabilities = cmp_cap })
      vim.lsp.config("glsl_analyzer", { capabilities = cmp_cap })
      vim.lsp.config("marksman", { capabilities = cmp_cap })
    end
  },
  { "smjonas/inc-rename.nvim", opts = {} }
}
