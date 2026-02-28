return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local ok, configs = pcall(require, 'nvim-treesitter.configs')
      if not ok then
        return
      end
      configs.setup({
        ensure_installed = {
          'ruby',
          'javascript',
          'typescript',
          'tsx',
          'html',
          'css',
          'python',
          'rust',
          'go',
          'c',
          'cpp',
          'java',
          'php',
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,  -- HTMLタグの自動閉じ
        },
        endwise = {
          enable = true,  -- Ruby の def/end 自動補完
        },
      })
    end,
    dependencies = {
      'RRethy/nvim-treesitter-endwise',  -- Ruby の end 自動補完
      'windwp/nvim-ts-autotag',         -- HTML タグの自動リネーム
    }
  }
}