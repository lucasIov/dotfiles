return {
  { "xzbdmw/colorful-menu.nvim" },
  {
    'saghen/blink.cmp',
    dependencies = {'saghen/blink.lib', 'rafamadriz/friendly-snippets'},

    build = function() require('blink.cmp').build():pwait() end,

    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_and_accept', 'fallback'},
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
        trigger = {
            show_on_accept_on_trigger_character = true,
            show_on_x_blocked_trigger_characters = { "'", '"', '(', '{', '[' }
        },
      },
      cmdline = {},
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      -- signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  }
}
