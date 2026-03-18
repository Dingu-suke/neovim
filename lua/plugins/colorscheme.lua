-- plugins/colorscheme.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      transparent = true,
    })
    vim.cmd[[colorscheme tokyonight]]
    
    -- 背景色のみ透明に設定（テキスト色やハイライト色は保持）
    local function set_transparent_bg()
      local groups = {
        "Normal", "NormalNC", "NormalFloat",
        "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
        "TelescopeNormal", "TelescopeBorder", "TelescopePromptBorder",
        "FloatBorder", "FloatTitle", "Pmenu", "PmenuSel",
        "SignColumn", "StatusLine", "StatusLineNC",
        "CursorLine", "ColorColumn", "LineNr",
        "PreviewNormal", "PreviewFloat", "Title",
      }
      for _, group in ipairs(groups) do
        pcall(function()
          local hl = vim.api.nvim_get_hl(0, { name = group })
          if hl then
            hl.bg = nil
            vim.api.nvim_set_hl(0, group, hl)
          end
        end)
      end
    end
    
    -- 行番号の視認性向上
    local function set_line_nr_hl()
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#e6e6e6", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64", bg = "NONE", bold = true })
    end

    local function apply_custom_hl()
      set_transparent_bg()
      set_line_nr_hl()
    end

    apply_custom_hl()

    -- colorscheme 変更時に再適用
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = apply_custom_hl
    })

  end
}