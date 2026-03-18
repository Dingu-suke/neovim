return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
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
        -- 前のエラーに移動
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        -- 次のエラーに移動
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
    end,
  }
}
