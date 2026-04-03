return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
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
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        highlight_modified = "all",
        icons = {
          git_placement = "after",
          glyphs = {
            git = {
              unstaged  = "~",
              staged    = "+",
              unmerged  = "!",
              renamed   = "R",
              untracked = "?",
              deleted   = "-",
              ignored   = ".",
            },
          },
        },
      },
      view = {
        float = {
          enable = false,
        },
      },
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
    }

    vim.keymap.set('n', '<BS>', function()
      vim.cmd('NvimTreeFocus')
    end, {silent = true, noremap = true})

    -- ツリーとバッファのアクティブ切り替え
    vim.keymap.set('n', '<leader><CR>', function()
      if vim.bo.filetype == 'NvimTree' then
        vim.cmd('wincmd l')
      else
        vim.cmd('NvimTreeFocus')
      end
    end, {silent = true, noremap = true})

    -- NvimTree 上で :w / :wq した場合、全バッファを保存する
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function(args)
        vim.bo[args.buf].buftype = "acwrite"
        vim.api.nvim_create_autocmd("BufWriteCmd", {
          buffer = args.buf,
          callback = function()
            vim.cmd("silent! wall")
            vim.bo.modified = false
          end,
        })
      end,
    })

    -- NvimTree + バッファだけの状態ならどちらから :q しても終了
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= '' then
            table.insert(floating_wins, w)
          end
        end
        local normal_wins = #wins - #floating_wins - #tree_wins
        if normal_wins <= 1 then
          local cur_win = vim.api.nvim_get_current_win()
          for _, w in ipairs(wins) do
            if w ~= cur_win and vim.api.nvim_win_get_config(w).relative == '' then
              local is_tree = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w)):match("NvimTree_") ~= nil
              pcall(vim.api.nvim_win_close, w, is_tree)
            end
          end
        end
      end
    })

    -- ツリーゾーンから Telescope を起動（バッファゾーンに移動）
    vim.keymap.set('n', '<space>lf', function()
      vim.api.nvim_command('wincmd l')
      vim.api.nvim_command('Telescope file_browser path=%:p:h select_buffer=true')
    end, {silent = true, noremap = true})
  end
}
