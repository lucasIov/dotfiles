vim.o.winborder = 'rounded'

-- line info
vim.o.number = true -- Enable line numbers
vim.o.relativenumber = true -- Enable relative line numbers

-- tab
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.tabstop = 2 -- Number of spaces a tab represents
vim.o.shiftwidth = 2 -- Number of spaces for each indentation
vim.o.softtabstop = 2

-- tabs & spaces special display
vim.o.list = true
vim.o.lcs = "tab: ,space:•"
vim.o.cursorline = true -- Highlight the current line

vim.o.termguicolors = true -- Enable 24-bit RGB colors
vim.cmd.colorscheme "catppuccin-nvim"

-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

-- lsp
vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_text = true,  -- show inline messages
	signs = true,         -- show signs in the gutter
	underline = true,     -- underline problematic text
	update_in_insert = false, -- don't update diagnostics while typing
	severity_sort = true,     -- sort diagnostics by severity
	-- virtual_lines = true,
})
