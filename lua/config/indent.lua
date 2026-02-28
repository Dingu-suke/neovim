-- 基本設定（グローバル）
vim.cmd([[
  set expandtab
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
]])

-- ファイルタイプごとの設定
vim.cmd([[
  augroup FileTypeIndent
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType typescript,typescriptreact,javascript,javascriptreact,ruby,html,css,json,yaml,lua setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  augroup END
]])

-- 確実に適用するための設定
vim.cmd([[
  augroup ForceIndent
    autocmd!
    autocmd BufEnter *.ts,*.tsx,*.js,*.jsx,*.rb setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd BufEnter *.py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  augroup END
]])

-- vimscript にすることによって順番に実行する