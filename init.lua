vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.cursorline = true
require('config.lazy')
require('config')   -- lua/config/init.lua（Shift/Option 矢印などのキーマップ）
require('keymap')   -- lua/keymap.lua（Undo/Redo・終了メニュー）