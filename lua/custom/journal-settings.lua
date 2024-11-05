local window_groups = require("custom.window_groups")

-- LOGGER ---------------------------------------------------------------------

-- Set up a logger
local log = require("plenary.log").new({
  plugin = "neorg_journal",
  level = "info",  -- Set this to "debug" for more verbose logging
})

-- UTILITIES ------------------------------------------------------------------

-- Function to get the current Neorg workspace root
local function get_neorg_workspace_root()
  -- Check if neorg is installed
  local ok, neorg = pcall(require, "neorg")
  if not ok then
    return nil
  end

  -- Get the current workspace (default at startup is nvim's cwd)
  local current_workspace = neorg.modules.get_module("core.dirman").get_current_workspace()
  if current_workspace then
    -- Return the workspace path
    return neorg.modules.get_module("core.dirman").get_workspace(current_workspace[1])
  end
end

-- Function to get the current Neorg journal root
local function get_neorg_journal_root()
  -- Get the current workspace (default at startup is nvim's cwd)
  local workspace_root = get_neorg_workspace_root()
  if workspace_root then
    -- Return the workspace journal path
    return workspace_root .. '/journal'
  end
end

-- JOURNAL --------------------------------------------------------------------

-- Function to set up the journal window configuration
local function setup_journal_windows()
  -- Close all existing windows
  vim.cmd('only')

  -- Get the current directory and extract the day
  local current_dir = vim.fn.expand('%:p:h')
  local day = vim.fn.fnamemodify(current_dir, ':t')

  -- Prepare file paths
  local journal_file = current_dir .. '/' .. day .. '.norg'
  local todo_file = current_dir .. '/todo.norg'

  -- Check if todo.norg exists, create it if it doesn't
  if vim.fn.filereadable(todo_file) == 0 then
    vim.fn.writefile({}, todo_file)
  end

  -- Open the journal file in the current window
  vim.cmd('edit ' .. journal_file)


  -- Create a new horizontal split and move to it
  vim.cmd('split')
  vim.cmd('wincmd j')

  -- Open the todo file in the new right window
  vim.cmd('edit ' .. todo_file)

  -- Move back to the top window (journal file)
  vim.cmd('wincmd k')
end

-- Command to nicely format the index/todo file of a Neorg journal
vim.api.nvim_create_user_command("NeorgFormatJournal", function()
  log:info("Trying to format journal")

  local current_path = vim.fn.expand("%:p")  -- Get the full path of the current file
  local journal_root = get_neorg_journal_root()

  if current_path:find(journal_root, 1, true) then
    setup_journal_windows()
    log:info("Journal formatted: " .. current_path)
  else
    log:info("Not in the journal directory. Current path: " .. current_path)
  end
end, {})

-- CONCEALER ------------------------------------------------------------------

local function setup_norg_conceal()
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.norg",
    callback = function()
      vim.wo.conceallevel = 2
      vim.wo.concealcursor = 'nc'
      vim.wo.foldminlines = 999

      local ns_id = vim.api.nvim_create_namespace('norg_conceal')

      local function conceal_lines()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for i, line in ipairs(lines) do
          if line:find("@code", 1, true) or line:find("@end", 1, true) then
            vim.api.nvim_buf_set_extmark(0, ns_id, i - 1, 0, {
              end_col = #line,
              conceal = ''
            })
          end
        end
      end

      conceal_lines()

      vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
        buffer = 0,
        callback = conceal_lines
      })
    end
  })
end

-- Call the function to set up the autocommand
setup_norg_conceal()

-- SQLITE-INTEGRATIONS --------------------------------------------------------
