-- list of various plugins

return {
  -- TODO:
  -- finish configure greeter
  -- finish configure status bar
  -- continue configure lsp
  -- git integretion

  { "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },

  { 'lewis6991/gitsigns.nvim', },

  { "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- signs = false,
    }
  },

  {
    "danymat/neogen",
    config = true,
  },

  { "windwp/nvim-ts-autotag",
    -- opts = { enable_close_on_slash = true --[[ </ ]] }
  },

  { "folke/ts-comments.nvim",
    -- dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" }, -- set nvim comment string
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  { "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "saghen/blink.cmp" },
  },

  { "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      win = {
        no_overlap = true,
        title = true,
        title_pos = "center",
        zindex = 1000,
        wo = {
          winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      layout = {
        width = { min = 20 }, -- min and max width of the columns
      },
    },
  },

  -- { 'saghen/blink.indent' },
  { 'saghen/blink.pairs',
    dependencies = 'saghen/blink.lib',

    version = '*',
    build = function() require('blink.pairs').download():pwait(60000) end,
    opts = {
      mappings = {
        enabled = true,
        cmdline = true,
        disabled_filetypes = {},
        wrap = {
          ['<C-b>'] = 'motion',
          ['<C-S-b>'] = 'motion_reverse',
        },
      },
      highlights = {
        enabled = true,
        cmdline = true,
        groups = { "BlinkPairsRed", "BlinkPairsYellow", "BlinkPairsBlue", "BlinkPairsOrange", "BlinkPairsGreen", "BlinkPairsPurple", "BlinkPairsCyan" },
        unmatched_group = 'BlinkPairsUnmatched',

        -- highlights matching pairs under the cursor
        matchparen = {
          enabled = true,
          -- known issue where typing won't update matchparen highlight, disabled by default
          cmdline = false,
          -- also include pairs not on top of the cursor, but surrounding the cursor
          include_surrounding = false,
          group = 'BlinkPairsMatchParen',
          priority = 250,
        },
      },
      debug = false,
    }
  },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {}
  },

  --[[{ 'romgrk/barbar.nvim', -- the preaty tab bar
    dependencies = {
      'lewis6991/gitsigns.nvim', -- for git status
      'nvim-tree/nvim-web-devicons', -- for file icons
    },
  },]]
  -- {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
}

