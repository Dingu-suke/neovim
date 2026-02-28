return {
  {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      -- Mason.nvimの設定
      require('mason').setup()
      
      -- Mason-lspconfigの設定
      require('mason-lspconfig').setup({
        -- 自動的にインストールしたい言語サーバーのリスト
        ensure_installed = {
          'pyright',
          'rust_analyzer',
          'gopls',
          'ts_ls', -- JavaScript/TypeScript
          'eslint',   -- JavaScript/TypeScript用リンター
          'intelephense',
          'solargraph',
          'ruby_lsp',  -- Railsプロジェクト用
          'clangd',
          'omnisharp',
          'jdtls',
          'cssls',    -- CSS
          'html',     -- HTML
          'tailwindcss', -- Tailwind CSS (React/Next.jsでよく使用)
        },
        -- automatic_installation は mason-lspconfig v2 で廃止 (automatic_enable に変更)
      })
      
      -- LSPの設定
      local lspconfig = require('lspconfig')
      
      -- キーマッピング関数
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        
        -- 定義ジャンプ
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- 型定義ジャンプ
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        -- 実装ジャンプ
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- リファレンス検索
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- ホバー情報表示
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- リネーム
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        -- コードアクション
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        -- 診断情報の表示
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        -- 次のエラーに移動
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        -- 前のエラーに移動
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      end
      
      -- LSPの機能を補完エンジンに連携するための設定
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- 言語サーバーの設定
      -- Python
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- Rust
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- Go
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- JavaScript/TypeScript (React/Next.js対応)
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
        },
      })
      
      -- ESLint
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- ESLintの自動修正を有効化
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        capabilities = capabilities,
        -- React/Next.jsプロジェクトでよく使用される設定
        settings = {
          workingDirectory = { mode = 'auto' },
        },
      })
      
      -- PHP
      lspconfig.intelephense.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- Ruby/Rails
      lspconfig.solargraph.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          solargraph = {
            diagnostics = true,
            -- Railsの補完を有効化
            completion = true,
            -- Railsフレームワークのサポートを有効化
            useBundler = true,
          },
        },
      })
      
      -- 新しいRuby LSP (Ruby/Railsの補完強化)
      lspconfig.ruby_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- CSS
      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- HTML
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- Tailwind CSS (React/Next.jsでよく使用)
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- Next.js/Reactでの設定
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                -- JSX/TSXでのTailwindクラス検出を強化
                'className="([^"]*)"',
                'tw="([^"]*)"',
                'tw\\.[^`]+`([^`]*)`',
              },
            },
          },
        },
      })
      
      -- C/C++
      lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- C#
      lspconfig.omnisharp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- Java
      lspconfig.jdtls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
      -- 診断表示のカスタマイズ
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      
      -- 補完エンジンの設定
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      -- スニペットの設定 (React/Next.js/Railsのスニペットをロード)
      require('luasnip.loaders.from_vscode').lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  }
}