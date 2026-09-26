return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  -- {
  --   "zaldih/themery.nvim",
  --   lazy = false,
  --   config = function()
  --     require("themery").setup({
  --       themes = {
  --         "catppuccin-macchiato", "catppuccin-mocha", "catppuccin-frappe",
  --         "kanagawa", "kanagawa-dragon", "kanagawa-wave",
  --         "tokyonight-moon", "tokyonight-night", "tokyonight-storm"
  --       },
  --     })
  --   end
  -- }
}
