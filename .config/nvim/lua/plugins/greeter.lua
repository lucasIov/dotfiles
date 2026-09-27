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

-- TODO: implement a way to remove middle folder when to mutch to fit in 70 character
--
-- function Print_table(tb)
--     for i, v in ipairs(tb) do
--       print(i, v)
--     end
-- end
--
-- local function total_str_tb_size(tb)
--   local ttsize = 0
--   for _, v in ipairs(tb) do
--     ttsize = ttsize + #v
--   end
--   return ttsize
-- end
--
-- function string.split(str, sep)
--   local res = {}
--
--   while #str do
--     local finded = string.find(str, sep)
--     if (finded == nil) then
--       if (#res) then
--         table.insert(res, str)
--       end
--       break
--     end
--     if (finded == 1) then
--       str = string.sub(str, 2)
--     else
--       table.insert(res, string.sub(str, 1, finded - 1))
--       str = string.sub(str, finded)
--     end
--   end
--
--   return res
-- end
--
-- local pathpart = string.split("/run/media/lucjd/Philips SSD/document/program/c/terminal_dungeon/echo_special.c", "/")
--
-- Print_table(pathpart)
-- print("==" .. total_str_tb_size(pathpart) .. "==" .. #pathpart)
--
-- local tb_start = {}
-- local tb_end = {}
-- while (#tb_start + #tb_end) < #pathpart and (total_str_tb_size(tb_start) + total_str_tb_size(tb_end) + (#tb_start + #tb_end)) < 70 do
--   if (#tb_end < #tb_start) then
--     table.insert(tb_end, 1, pathpart[#pathpart - #tb_end])
--   else
--     table.insert(tb_start, pathpart[#tb_start + 1])
--   end
-- end
--
-- table.insert(tb_start, "[..]")
-- table.move(tb_end, 1, #tb_end, #tb_start + 1, tb_start)
-- print("========")
--
-- Print_table(tb_start)
-- print("==" .. total_str_tb_size(tb_start) .. "==" .. #tb_start)
--
-- print(table.concat(tb_start, "/"))

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
local function button(sc, txt, keybind)
  return {
    type = "button", val = txt,
    on_press = function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true), "t", false) end,
    opts = {
      position = "center",
      shortcut = "[" .. sc .. "] ",
      cursor = 1,
      width = 70,
      align_shortcut = "left",
      hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
      shrink_margin = false,
      keymap = { "n", sc:gsub("%s", ""):gsub(leader, "<leader>"), keybind, { noremap = true, silent = true, nowait = true } },
    },
  }
end

local devicons = require('nvim-web-devicons')

return {
  "goolord/alpha-nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require("alpha")
    local utils = require("alpha.utils")

    local function mru(start, cwd, orcwd)
      local found = utils.get_mru(orcwd, 10, function (path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains({ "gitcommit" }, ext)) or (not orcwd and string.sub(path, 1, #cwd) == cwd)
      end)

      local tbl = {}
      for i, fn in ipairs(found) do
        local short_fn = fn
        if orcwd then
          short_fn = vim.fn.fnamemodify(fn, ":.")
        else
          short_fn = vim.fn.fnamemodify(fn, ":~")
        end

        short_fn = vim.F.if_nil(short_fn, fn)
        local fb_hl = {}
        local ico, col = devicons.get_icon(fn, utils.get_extension(fn), { default = true })
        if col then
          table.insert(fb_hl, { col, 0, #ico })
        end
        local ico_txt = ico .. "  "

        -- if (#short_fn > (70 - #ico_txt)) then
        -- split()
        -- end

        local fn_start = short_fn:match(".*[/\\]")
        if fn_start ~= nil then
          table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
        end

        local file_button_el = button(tostring(i + start - 1), ico_txt .. short_fn, "<cmd>e " .. vim.fn.fnameescape(fn) .. " <CR>")
        file_button_el.opts.hl = fb_hl
        tbl[i] = file_button_el
      end
      return { type = "group", val = tbl, opts = {}, }
    end

    alpha.setup({
      layout = {
        { type = "padding", val = 1 },
        { type = "text", val = banner, opts = { hl = "Type", shrink_margin = false, position = "center" } },
        { type = "padding", val = 2 },
        { type = "group", val = { button("e", "New file", "<cmd>ene <CR>"), button("q", "Quit", "<cmd>q <CR>") } },
        { type = "padding", val = 1 },
        { type = "group",
          val = function()
            local cwd = vim.fn.getcwd()
            return {
              { type = "text",    val = vim.fn.fnamemodify(cwd, ":~"), opts = { hl = "SpecialComment", position = "center", shrink_margin = false } },
              { type = "padding", val = 1 },
              { type = "group", val = function() return { mru(0, cwd, cwd) } end },
            }
          end,
        },
        { type = "padding", val = 1 },
        { type = "group",
          val = {
            { type = "text",    val = "other", opts = { hl = "SpecialComment", position = "center" } },
            { type = "padding", val = 1 },
            { type = "group", val = function() return { mru(10, vim.fn.getcwd()) } end },
          }
        },
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
              alpha.redraw()
              vim.cmd('AlphaRemap')
            end,
          })
        end,
      },
    })
  end,
}
