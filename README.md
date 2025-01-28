# 追加予定の機能

## 表示・UI関連
- [ ] 行数表示
 - 組み込み機能: `set number` または `set number relativenumber`（相対的な行数表示）
 - プラグイン候補:
   - [numbers.vim](https://github.com/myusuf3/numbers.vim)
     - 行数とrelative行数の賢い切り替え
   - [vim-numbertoggle](https://github.com/jeffkreeftmeijer/vim-numbertoggle)
     - モードに応じて自動的に行数表示を切り替え

### 設定サンプル
```lua
-- 基本的な行数表示（組み込み機能を使用する場合）
vim.wo.number = true                -- 行数を表示
vim.wo.relativenumber = true        -- 相対的な行数を表示

-- または
vim.cmd[[
 set number               
 set relativenumber       
]]

## Git 関連
- [ ] LazyGit インテグレーション
  - プラグイン候補: [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
- [ ] Git グラフ表示
  - プラグイン候補: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
  - プラグイン候補: [diffview.nvim](https://github.com/sindrets/diffview.nvim)

## コード補完・開発支援
- [ ] React 自動インポート
  - プラグイン候補: [nvim-lsp-ts-utils](https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils)
  - LSP設定で対応可能
- [ ] 自動タグリネーム (Auto Rename Tag)
  - プラグイン候補: [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
- [ ] Ruby の endwise 機能
  - プラグイン候補: [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [ ] コード参照機能 (F12相当)
  - LSP設定で対応可能 (`gd`, `gr` などのキーマッピング)
- [ ] Tailwind CSS インテリセンス
  - プラグイン候補: [tailwindcss-language-server](https://github.com/tailwindlabs/tailwindcss-intellisense)
  - LSP設定で対応可能
- [ ] Next.js スニペット
  - プラグイン候補: [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
  - プラグイン候補: [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

## UI/UX
- [ ] ターミナルウィンドウ
  - プラグイン候補: [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [ ] ファイルアイコン表示
  - プラグイン候補: [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
  - プラグイン候補: [vim-devicons](https://github.com/ryanoasis/vim-devicons)

## コードフォーマット
- [ ] Prettier サポート
  - プラグイン候補: [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
  - プラグイン候補: [prettier.nvim](https://github.com/MunifTanjim/prettier.nvim)

## インストール要件
- Nerdフォント（アイコン表示に必要）
