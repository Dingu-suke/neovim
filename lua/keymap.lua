-- Undo/Redo with Command key (macOS)
vim.keymap.set('n', '<D-z>', 'u', { noremap = true, silent = true })
vim.keymap.set('n', '<D-Z>', '<C-r>', { noremap = true, silent = true })

-- Terminal (VSCode Cmd+J 風トグル / 同一シェルを 2 サイズで切替)
local term = { buf = nil, win = nil, kind = nil }

local function term_alive()
  if not (term.buf and vim.api.nvim_buf_is_valid(term.buf)) then
    return false
  end
  local ok, job = pcall(vim.api.nvim_buf_get_var, term.buf, 'terminal_job_id')
  return ok and job and vim.fn.jobwait({ job }, 0)[1] == -1
end

local function show_term(height, kind)
  if term.win and vim.api.nvim_win_is_valid(term.win) then
    vim.api.nvim_set_current_win(term.win)
  elseif term_alive() then
    vim.cmd(('botright sbuffer %d'):format(term.buf))
    term.win = vim.api.nvim_get_current_win()
  else
    if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
      pcall(vim.api.nvim_buf_delete, term.buf, { force = true })
    end
    vim.cmd('botright new')
    vim.cmd('terminal')
    term.buf = vim.api.nvim_get_current_buf()
    term.win = vim.api.nvim_get_current_win()
    vim.bo[term.buf].bufhidden = 'hide'
  end
  vim.api.nvim_win_set_height(term.win, height)
  term.kind = kind
  vim.cmd('startinsert')
end

local function hide_term()
  if term.win and vim.api.nvim_win_is_valid(term.win) then
    vim.api.nvim_win_hide(term.win)
  end
  term.win = nil
  term.kind = nil
end

local function toggle(kind, height)
  if term.kind == kind and term.win and vim.api.nvim_win_is_valid(term.win) then
    hide_term()
  else
    show_term(height, kind)
  end
end

local BOTTOM_HEIGHT = 15
local function large_height()
  return math.floor(vim.o.lines * 2 / 3)
end

vim.keymap.set('n', '<leader>t', function() toggle('bottom', BOTTOM_HEIGHT) end, { silent = true })
vim.keymap.set('n', 'tt', function() toggle('large', large_height()) end, { silent = true })
vim.keymap.set('n', '<D-j>', function() toggle('bottom', BOTTOM_HEIGHT) end, { silent = true })
vim.keymap.set('t', '<D-j>', function() toggle('bottom', BOTTOM_HEIGHT) end, { silent = true })

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.cmd('startinsert')
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { silent = true })
