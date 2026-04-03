-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua
return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup({
        ui = {
          check_outdated_packages_on_open = true,
          border = "rounded",
        },
      })
      
      require('mason-lspconfig').setup({
        -- 自動的にインストールする言語サーバーを指定
        ensure_installed = {
          -- Ruby/Rails
          'solargraph',
          'ruby_lsp',
          
          -- JavaScript/TypeScript/React/Next.js
          'ts_ls',
          'eslint',
          'tailwindcss',
          
          -- Rust
          'rust_analyzer',
          
          -- Java
          'jdtls',
          
          -- Go
          'gopls',
          
          -- C/C++
          'clangd',
          
          -- C#
          'omnisharp',
          
          -- PHP
          'intelephense',
          
          -- HTML/CSS
          'html',
          'cssls',
        },
        -- automatic_installation は mason-lspconfig v2 で廃止 (automatic_enable に変更)
      })
    end
  },
}