-- plugins/nvim-treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "ruby", "typescript", "tsx", "javascript", "embedded_template" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        use_languagetree = true,
      },
      indent = {
        enable = true
      }
    })
  end
}