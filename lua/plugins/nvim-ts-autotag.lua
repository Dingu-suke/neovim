return {
  {
    'windwp/nvim-ts-autotag',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    config = function()
      require('nvim-ts-autotag').setup({
        filetypes = {
          'html', 'xml', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'vue',
          'tsx', 'jsx', 'rhtml', 'erb',
        },
      })
    end
  }
}