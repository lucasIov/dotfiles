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

  --[[{ 'romgrk/barbar.nvim', -- the preaty tab bar
    dependencies = {
      'lewis6991/gitsigns.nvim', -- for git status
      'nvim-tree/nvim-web-devicons', -- for file icons
    },
  },]]

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 } -- the cool color
}

