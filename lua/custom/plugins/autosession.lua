return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<C-s>', '<cmd>SessionSearch<CR>', desc = 'Session search' },
  },
  config = function()
    require('auto-session').setup({
      auto_save_enabled = false,
      -- ⚠️ This will only work if Telescope.nvim is installed
      -- The following are already the default values, no need to provide them if these are already the settings you want.
      session_lens = {
        -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
        mappings = {
          -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
          delete_session = { "i", "<C-D>" },
          alternate_session = { "i", "<C-S>" },
        },
      },
    })
  end,
}
