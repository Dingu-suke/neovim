-- scratch-buffer: ローカルプラグイン (~/Projects/NeofimPlugins/scratch-buffer が存在しない場合は無効)
return {
  dir = vim.fn.expand("~/Projects/NeofimPlugins/scratch-buffer"),
  name = "scratch-buffer",
  enabled = vim.fn.isdirectory(vim.fn.expand("~/Projects/NeofimPlugins/scratch-buffer")) == 1,
  config = function ()
    require('scratch-buffer').setup()
  end
}