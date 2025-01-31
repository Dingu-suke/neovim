return {
  'luukvbaal/statuscol.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- Git の差分表示に必要
  },
  config = function()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      bt_ignore = { 'terminal', 'nofile', 'ddu-ff', 'ddu-ff-filter' },
      
      relculright = true,
      segments = {
        {
          sign = {
            name = { 'Diagnostic.*' },
            maxwidth = 1,
          },
        },
        {
          sign = {
            namespace = { 'gitsigns' },
            maxwidth = 1,
            colwidth = 1,
            wrap = true,
          },
        },
        {
          text = { builtin.lnumfunc },
        },
        { text = { '│' } },
      },
    })
  end
}