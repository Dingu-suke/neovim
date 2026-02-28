-- Shift+矢印で選択状態で移動
vim.api.nvim_set_keymap('n', '<S-Right>', 'v<Right>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Left>', 'v<Left>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Up>', 'v<Up>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Down>', 'v<Down>', {noremap = true})
vim.api.nvim_set_keymap('v', '<S-Right>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('v', '<S-Left>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('v', '<S-Up>', '<Up>', {noremap = true})
vim.api.nvim_set_keymap('v', '<S-Down>', '<Down>', {noremap = true})

-- Option+矢印キーに相当する操作のマッピング
vim.api.nvim_set_keymap('n', '<A-Right>', 'e', {noremap = true})  -- 単語の終わりに移動
vim.api.nvim_set_keymap('n', '<A-Left>', 'b', {noremap = true})   -- 単語の始めに移動
vim.api.nvim_set_keymap('v', '<A-Right>', 'e', {noremap = true})  -- ビジュアルモードでも同様
vim.api.nvim_set_keymap('v', '<A-Left>', 'b', {noremap = true})   -- ビジュアルモードでも同様

