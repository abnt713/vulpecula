if vim.fn.exists '+termguicolors'
  vim.o['termguicolors'] = true

vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.wo.cursorline = true

vim.opt.colorcolumn = '80'

indent_size = 4
vim.bo.shiftwidth = indent_size
vim.bo.smartindent = true
vim.bo.tabstop = indent_size
vim.bo.softtabstop = indent_size

vim.g.netrw_banner = 0
vim.cmd 'au BufRead,BufNewFile *.md,*.txt setlocal textwidth=80'
