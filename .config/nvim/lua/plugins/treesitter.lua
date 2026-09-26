return {
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    'nvim-treesitter/nvim-treesitter', -- the core of a lot of things
    -- lazy = false,
    build = ':TSUpdate',
    config = function ()
      local ts = require("nvim-treesitter")
      ts.setup({})
      ts.install({
          "asm",
          "bash",
          "c", "cpp", "glsl", "printf",
          "css", "html", "javascript", "php", "jsdoc",
          "lua", "luadoc", "luap",
          "markdown", "markdown_inline", "latex", "typst",
          "python",
          "vim", "vimdoc",
          "toml", "json", "xml", "yaml",
          "diff",
          "regex",
          -- "query", "tsx", "typescript",
        })
      end
  }
}
