-- Settings termguicolors
if vim.fn.exists '+termguicolors'
  vim.o['termguicolors'] = true

-- Setting <Space> as the leader key.
vim.g.mapleader = " "

-- Numbers, limits and cursor.
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.wo.cursorline = true
vim.opt.colorcolumn = '80'

-- Indentation.
indent_size = 4
vim.bo.shiftwidth = indent_size
vim.bo.smartindent = true
vim.bo.tabstop = indent_size
vim.bo.softtabstop = indent_size

-- Disabling Netrw banner.
vim.g.netrw_banner = 0

-- Setting line wrapping for markdown and txt files.
vim.cmd 'au BufRead,BufNewFile *.md,*.txt setlocal textwidth=80'

-- Handy function to retrieve a file reference and copy it to the clipboard.
-- The resulting format is: {path}/{file}.{ext}:{line_number} 
-- example: moon/vulpecula/editor.moon:30
export file_reference
file_reference = ->
  fileref = vim.fn.expand('%') .. ':' .. vim.fn.line('.')
  vim.fn.setreg '+', fileref
  print fileref, 'copied to clipboard'

vim.api.nvim_set_keymap(
  'n', '<Leader>fr', '<cmd>lua file_reference()<CR>', {noremap: true, silent: true}
)
