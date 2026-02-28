return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { 
    "nvim-telescope/telescope.nvim", 
    "nvim-lua/plenary.nvim" 
  },
  config = function()
    require("telescope").setup({
      extensions = {
        file_browser = {
          hijack_netrw = true,
          mappings = {
            -- キーマッピングはデフォルトのまま使用
          },
        },
      },
    })
    
    -- エクステンション読み込み
    require("telescope").load_extension("file_browser")
    
    -- キーマップ設定
    -- バッファゾーンに切り替えてから Telescope を起動
    vim.keymap.set(
      "n", 
      "<space>lf",
      function()
        -- ツリーゾーンからバッファゾーンに移動
        vim.api.nvim_command("wincmd l")
        -- Telescope を起動
        vim.api.nvim_command("Telescope file_browser path=%:p:h select_buffer=true")
      end,
      { noremap = true, silent = true }
    )
  end
}