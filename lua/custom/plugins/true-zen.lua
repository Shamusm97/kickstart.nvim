---@type LazyPluginSpec
return {
  "true-zen.nvim",
  dir = vim.fn.expand('$HOME') .. "/repos/true-zen.nvim",
  config = function()
    require('true-zen').setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
  end
}
