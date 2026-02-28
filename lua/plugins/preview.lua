return {
  'b0o/nvim-tree-preview.lua',
  dependencies = {
    'nvim-lua/plenary.nvim',
    '3rd/image.nvim',
  },
  config = function()
    require('nvim-tree-preview').setup({
      keymaps = {
        ['<Esc>'] = { action = 'close', unwatch = true },
        ['<Tab>'] = { action = 'toggle_focus' },
        ['<CR>'] = { open = 'edit' },
        ['<C-t>'] = { open = 'tab' },
        ['<C-v>'] = { open = 'vertical' },
        ['<C-x>'] = { open = 'horizontal' },
        ['<C-n>'] = { action = 'select_node', target = 'next' },
        ['<C-p>'] = { action = 'select_node', target = 'prev' },
      },
      min_width = 80,
      min_height = 30,
      -- max_width と max_height を大きく設定
      -- calculate_win_size() が幅・高さの50%を計算するため、
      -- 実際に表示されるサイズは約(max_width/2, max_height/2)になる
      -- バッファゾーンの4/5 ≈ 80% を目指すため
      -- 画面幅・高さから逆算した大きな値を設定
      max_width = 1000,
      max_height = 1000,
      -- バッファゾーンの4/5 のサイズを目指す
      max_width_window_percentage = 80,
      max_height_window_percentage = 80,
      wrap = false,
      border = 'rounded',
      zindex = 100,
      show_title = true,
      title_pos = 'top-center',
      title_format = ' %s ',
      follow_links = true,
      -- プレビューウィンドウの位置設定
      -- バッファ内の中央に表示するように計算
      win_position = {
        row = function(tree_win, size)
          -- tree_win: nvim tree ウィンドウのID
          -- size: { width: number, height: number } - 実際のプレビューサイズ
          local ui = vim.api.nvim_list_uis()[1]
          if not ui or not size.height then return 0 end
          
          -- バッファゾーンの高さ
          local buf_height = ui.height
          -- 中央よりも少し上に配置（中央から高さの1/4上にずらす）
          local center = math.floor((buf_height - size.height) / 2)
          local offset = math.floor(size.height / 24)
          return math.max(0, center - offset)
        end,
        col = function(tree_win, size)
          -- ツリーウィンドウの幅を取得して、バッファ領域内で中央配置
          local ui = vim.api.nvim_list_uis()[1]
          if not ui or not size.width then return 0 end
          
          -- ツリーウィンドウの幅を取得
          local tree_width = vim.api.nvim_win_get_width(tree_win)
          -- バッファウィンドウの幅 = UI全幅 - ツリーウィンドウの幅
          local buf_width = ui.width - tree_width
          -- 実際のプレビュー幅を使用して、バッファ領域内で中央に配置
          return tree_width + math.floor((buf_width - size.width) / 2)
        end,
      },
      image_preview = {
        enable = false,
        patterns = {
          '.*%.png$',
          '.*%.jpg$',
          '.*%.jpeg$',
          '.*%.gif$',
          '.*%.webp$',
          '.*%.avif$',
        },
      },
      watch = {
        event = 'CursorMoved'
      },
      -- プラグインの calculate_win_size() を修正済み
      -- 幅・高さの計算が 50% → 80% に変更されている
    })
  end,
}
