-- telescope
local tl_b = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tl_b.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', tl_b.live_grep,  { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', tl_b.buffers,    { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', tl_b.help_tags,  { desc = 'Telescope help tags' })

vim.keymap.set('n', '<Leader>;', require('dropbar.api').pick, { desc = 'Pick symbols in winbar' })
vim.keymap.set("n", "<leader>r", ":IncRename ")
vim.keymap.set("n", "<c-b>", ":Neotree filesystem toggle left<cr>", { desc = "toggle the filesystem panel" })

-- terminal
vim.keymap.set('t', '<C-Esc>', [[<C-\><C-n>]], { desc = 'close the terminal' })

-- lsp
-- vim.keymap.set('n', 'K',  vim.lsp.buf.hover, { desc = 'display info for the current ' })
vim.keymap.set('n', 'K',  function () require("pretty_hover").hover() end, { desc = 'display info for the current ' })

-- other
vim.keymap.set("n", "<tab>",   ">>", {}) -- so much easier than (> & <)
vim.keymap.set("n", "<s-tab>", "<<", {})

vim.keymap.set("v", "<tab>",   ">", {})
vim.keymap.set("v", "<s-tab>", "<", {})
-- vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggle `markview` globally" })
