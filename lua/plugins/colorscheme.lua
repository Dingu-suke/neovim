-- plugins/colorscheme.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      transparent = false,
    })
    vim.cmd[[colorscheme tokyonight]]
  end
}