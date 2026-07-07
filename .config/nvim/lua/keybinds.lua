-- telescope
local tl_b = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tl_b.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', tl_b.live_grep,  { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', tl_b.buffers,    { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', tl_b.help_tags,  { desc = 'Telescope help tags' })

-- terminal
vim.keymap.set('t', '<C-Esc>', [[<C-\><C-n>]], { desc = 'close the terminal' })

-- lsp
vim.keymap.set('n', 'K',  vim.lsp.buf.hover, { desc = 'display info for the current ' })
-- vim.keymap.set('n', 'gd', vim.lsp.definition, {})
-- vim.keymap.set({'n', 'gd'}, 'rleader>ca', vim.lsp.code_action, {})

-- neotree
vim.keymap.set("n", "<c-b>", ":Neotree filesystem toggle left<cr>", { desc = "toggle the filesystem panel" })

-- other in normal mode
vim.keymap.set("n", "<tab>",   ">>", {}) -- so much easier than (> & <)
vim.keymap.set("n", "<s-tab>", "<<", {})

-- zen mode
vim.keymap.set("n", "<leader>z", ":ZenMode<cr>")

