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
          "oxfmt", -- { "javascript", "javascriptreact", "typescript", "typescriptreact", "toml", "json", "jsonc", "json5", "yaml", "html", "vue", "handlebars", "css", "scss", "less", "graphql", "markdown" }
        }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local cmp_cap = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config("lua_ls", { capabilities = cmp_cap })
      vim.lsp.config("rust_analyzer", { capabilities = cmp_cap })
      vim.lsp.config("asm_lsp", { capabilities = cmp_cap })
      vim.lsp.config("bashls", { capabilities = cmp_cap })
      vim.lsp.config("clangd", { capabilities = cmp_cap })
      vim.lsp.config("oxfmt", { capabilities = cmp_cap })
    end
  },
}
