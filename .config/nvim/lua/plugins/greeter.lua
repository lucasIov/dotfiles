local banner = {
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
  [[                                                                       ]],
  [[                                                                       ]],
}

local if_nil = vim.F.if_nil
local fnamemodify = vim.fn.fnamemodify

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = "[" .. sc .. "] ",
    cursor = 1,
    width = 50,
    align_shortcut = "left",
    hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
    shrink_margin = false,
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return { type = "button", val = txt, on_press = on_press, opts = opts, }
end


return {
  "goolord/alpha-nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require("alpha")
    local utils = require("alpha.utils")

    local file_icons = { enabled = true, highlight = true, provider = "devicons", }
    local function icon(fn)
      return utils.get_icon(file_icons, fn)
    end

    local function file_button(fn, sc, short_fn, autocd)
      short_fn = if_nil(short_fn, fn)
      local ico_txt
      local fb_hl = {}
      if file_icons.enabled then
        local ico, hl = icon(fn)
        local hl_option_type = type(file_icons.highlight)
        if hl_option_type == "boolean" then
          if hl and file_icons.highlight then
            table.insert(fb_hl, { hl, 0, #ico })
          end
        end
        if hl_option_type == "string" then
          table.insert(fb_hl, { file_icons.highlight, 0, #ico })
        end
        ico_txt = ico .. "  "
      else
        ico_txt = ""
      end
      local cd_cmd = (autocd and " | cd %:p:h" or "")
      local file_button_el = button(sc, ico_txt .. short_fn, "<cmd>e " .. vim.fn.fnameescape(fn) .. cd_cmd .. " <CR>")
      local fn_start = short_fn:match(".*[/\\]")
      if fn_start ~= nil then
        table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
      end
      file_button_el.opts.hl = fb_hl
      return file_button_el
    end

    local default_mru_ignore = { "gitcommit" }

    local mru_opts = {
      ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
      end,
      autocd = false
    }

    local function mru(start, cwd, items_number, opts)
      opts = opts or mru_opts
      items_number = if_nil(items_number, 10)

      local found = utils.get_mru(cwd, items_number, opts.ignore)

      local tbl = {}
      for i, fn in ipairs(found) do
        local short_fn
        if cwd then
          short_fn = fnamemodify(fn, ":.")
        else
          short_fn = fnamemodify(fn, ":~")
        end
        local file_button_el = file_button(fn, tostring(i + start - 1), short_fn, opts.autocd)
        tbl[i] = file_button_el
      end
      return { type = "group", val = tbl, opts = {}, }
    end

    local section = {
      mru = { type = "group",
        val = {
          { type = "padding", val = 1 },
          { type = "text",    val = "MRU", opts = { hl = "SpecialComment", width = 50, position = "center" } },
          { type = "padding", val = 1 },
          { type = "group",
            val = function()
              return { mru(10) }
            end,
          },
        },
      },
      mru_cwd = { type = "group",
        val = function()
          local cwd = vim.fn.getcwd()
          return {
            { type = "padding", val = 1 },
            { type = "text",    val = "MRU " .. fnamemodify(cwd, ":~"), opts = { hl = "SpecialComment", width = 50, position = "center", shrink_margin = false } },
            { type = "padding", val = 1 },
            { type = "group",
              val = function() return { mru(0, cwd) } end,
              opts = { shrink_margin = false },
            },
          }
        end,
      }
    }

    local mru_sections = { "mru_cwd", "mru" }

    local config = {
      layout = {
        { type = "padding", val = 1 },
        { type = "text", val = banner, opts = { hl = "Type", shrink_margin = false, position = "center" }},
        { type = "padding", val = 2 },
        { type = "group",
          val = {
            button("e", "New file", "<cmd>ene <CR>"),
            button("q", "Quit", "<cmd>q <CR>"),
          },
        },
        { type = "group",
          val = function()
            local result = {}
            for _, name in ipairs(mru_sections) do
              if section[name] then
                table.insert(result, section[name])
              end
            end
            return result
          end,
        },
        { type = "padding", val = 1 },
      },
      opts = {
        margin = 3,
        redraw_on_resize = false,
        setup = function()
          vim.api.nvim_create_autocmd('DirChanged', {
            pattern = '*',
            group = "alpha_temp",
            callback = function()
              utils.mru_cache = {}
              utils.git_toplevel_cache = {}
              require('alpha').redraw()
              vim.cmd('AlphaRemap')
            end,
          })
        end,
      },
    }

    alpha.setup(config)
  end,
}
