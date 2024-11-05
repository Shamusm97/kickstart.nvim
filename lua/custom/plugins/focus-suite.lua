---@type LazyPluginSpec
return {
  "focus-suite.nvim",
  dir = vim.fn.expand('$HOME') .. "/projects/focus-suite.nvim",
  opts = {
    debug_mode = true,
  },
}
