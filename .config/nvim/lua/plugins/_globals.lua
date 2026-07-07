-- list of various plugins

return {
  -- TODO:
  -- finish configure greeter
  -- finish configure status bar
  -- finish configure nvim-cmp
  -- finish configure telescope
  -- continue configure lsp
  -- git integretion

  { "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },

  { 'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup({})
    end
  },

  { "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
      },
    }
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 } -- the cool color
}

