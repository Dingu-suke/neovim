return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    -- vim.ui.select（終了メニューなど）を telescope で表示
    select = {
      backend = { "telescope", "builtin" },
    },
    -- vim.ui.input（名前入力・rename など）をフローティングに
    input = {
      enabled = true,
    },
  },
}
