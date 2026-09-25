return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    -- nvim 0.11+ の新 API (vim.lsp.config / vim.lsp.enable) を使用。
    -- lspconfig はサーバごとのデフォルト設定 (lsp/*.lua) を提供するために残す。
    config = function()
      -- キーマッピングは LspAttach で一括設定（旧 on_attach 相当）
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
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
          vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
          -- 次のエラーに移動
          vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)

          -- ESLint: 保存時に自動修正
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'eslint' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end
        end,
      })

      -- 補完エンジン連携の capabilities を全サーバ共通に適用
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- サーバごとの追加設定（capabilities はマージされる）

      -- JavaScript/TypeScript (React/Next.js対応)
      vim.lsp.config('ts_ls', {
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

      -- ESLint (React/Next.jsプロジェクト向け)
      vim.lsp.config('eslint', {
        settings = {
          workingDirectory = { mode = 'auto' },
        },
      })

      -- Ruby/Rails
      vim.lsp.config('solargraph', {
        settings = {
          solargraph = {
            diagnostics = true,
            completion = true,
            useBundler = true,
          },
        },
      })

      -- Tailwind CSS (React/Next.jsでよく使用)
      vim.lsp.config('tailwindcss', {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                'className="([^"]*)"',
                'tw="([^"]*)"',
                'tw\\.[^`]+`([^`]*)`',
              },
            },
          },
        },
      })

      -- 有効化する言語サーバ一覧
      vim.lsp.enable({
        'pyright',       -- Python
        'rust_analyzer', -- Rust
        'gopls',         -- Go
        'ts_ls',         -- JavaScript/TypeScript
        'eslint',        -- ESLint
        'intelephense',  -- PHP
        'solargraph',    -- Ruby/Rails
        'ruby_lsp',      -- Ruby LSP
        'cssls',         -- CSS
        'html',          -- HTML
        'tailwindcss',   -- Tailwind CSS
        'clangd',        -- C/C++
        'omnisharp',     -- C#
        'jdtls',         -- Java
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
