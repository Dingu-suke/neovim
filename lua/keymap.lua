-- Undo/Redo with Command key (macOS)
vim.keymap.set('n', '<D-z>', 'u', { noremap = true, silent = true })
vim.keymap.set('n', '<D-Z>', '<C-r>', { noremap = true, silent = true })
