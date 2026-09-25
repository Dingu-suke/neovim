-- Undo/Redo with Command key (macOS)
vim.keymap.set('n', '<D-z>', 'u', { noremap = true, silent = true })
vim.keymap.set('n', '<D-Z>', '<C-r>', { noremap = true, silent = true })

-- 終了メニュー: <leader>q (= Space q) で選択式に終了
-- :wq / :q / :q! / :qa! などを打たずにメニューから選ぶ
local quit_actions = {
  { label = "保存して閉じる          :wq",   cmd = "write | quit" },
  { label = "閉じる（変更なし）      :q",     cmd = "quit" },
  { label = "保存せず閉じる          :q!",    cmd = "quit!" },
  { label = "保存のみ                :w",     cmd = "write" },
  { label = "全部保存して終了        :wqa",   cmd = "wall | qall" },
  { label = "全部保存せず終了        :qa!",   cmd = "qall!" },
  { label = "キャンセル",                     cmd = nil },
}

vim.keymap.set('n', '<leader>q', function()
  vim.ui.select(quit_actions, {
    prompt = "終了方法を選択:",
    format_item = function(item) return item.label end,
  }, function(choice)
    if choice and choice.cmd then
      vim.cmd(choice.cmd)
    end
  end)
end, { noremap = true, silent = true, desc = "終了メニュー" })
