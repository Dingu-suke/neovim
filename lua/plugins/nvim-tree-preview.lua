return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    {
      'b0o/nvim-tree-preview.lua',
      dependencies = {
        'nvim-lua/plenary.nvim',
        '3rd/image.nvim', -- Optional, for previewing images
      },
    },
  },
  config = function()
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {silent = true, noremap = true})    
    vim.keymap.set('n', '<C-m>', ':NvimTreeFindFile<CR>', {silent = true, noremap = true})  -- .key を .set に修正
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        require("nvim-tree.api").tree.open()
      end
    })
    require('nvim-tree').setup {

      on_attach = function(bufnr)
        -- 起動時に自動で開く
        local api = require('nvim-tree.api')
        api.config.mappings.default_on_attach(bufnr)
    
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
    
        local preview = require('nvim-tree-preview')
    
        vim.keymap.set('n', 'p', preview.watch, opts 'Preview (Watch)')
        vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
        vim.keymap.set('n', '<C-f>', function() return preview.scroll(4) end, opts 'Scroll Down')
        vim.keymap.set('n', '<C-b>', function() return preview.scroll(-4) end, opts 'Scroll Up')
    
        -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
        vim.keymap.set('n', '<Tab>', function()
          local ok, node = pcall(api.tree.get_node_under_cursor)
          if ok and node then
            if node.type == 'directory' then
              api.node.open.edit()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end, opts 'Preview')
      end,
      
      vim.keymap.set('n', '<BS>', function()
        -- まずツリーにフォーカスを移す
        vim.cmd('NvimTreeFocus')
        -- 少し待ってからプレビューを実行
        vim.defer_fn(function()
            local preview = require('nvim-tree-preview')
            preview.watch()
        end, 10)  -- 10ミリ秒の遅延
      end, {silent = true, noremap = true})
    }
  end
}