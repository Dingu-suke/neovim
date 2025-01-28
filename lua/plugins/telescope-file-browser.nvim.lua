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
    vim.keymap.set(
      "n", 
      "<space>fb", 
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>", 
      { noremap = true }
    )
  end
}