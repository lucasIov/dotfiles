return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = {
    close_if_last_window = true,
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<C-b>"] = "close_window",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
  }
}
