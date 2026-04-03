return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true, -- treesitterとの連携
        ts_config = {
          lua = {'string'},
          javascript = {'template_string'},
          java = false,
        },
      })
      
      -- nvim-cmpとの連携設定
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  }
}