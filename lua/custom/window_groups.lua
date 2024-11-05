local M = {}

-- Store window groups
M.window_groups = {}

-- Store option sets
M.option_sets = {}



-- Function to create a new window group
function M.create_window_group(group_name)
  if not M.window_groups[group_name] then
    M.window_groups[group_name] = {}
  end
end

-- Function to add a window to a group and save its current options
function M.add_to_window_group(group_name, win_id)
  if M.window_groups[group_name] then
    local window_data = {
      id = win_id,
      saved_options = M.save_window_options(win_id)
    }
    table.insert(M.window_groups[group_name], window_data)
  end
end

-- Function to remove a window from a group
function M.remove_from_window_group(group_name, win_id)
  if M.window_groups[group_name] then
    for i, window_data in ipairs(M.window_groups[group_name]) do
      if window_data.id == win_id then
        table.remove(M.window_groups[group_name], i)
        break
      end
    end
  end
end

-- Function to create an option set
function M.create_option_set(set_name, options)
  M.option_sets[set_name] = options
end

-- Function to apply an option set to a group
function M.apply_option_set(group_name, set_name)
  if M.window_groups[group_name] and M.option_sets[set_name] then
    for _, window_data in ipairs(M.window_groups[group_name]) do
      for option, value in pairs(M.option_sets[set_name]) do
        vim.api.nvim_set_option_value(option, value, {win = window_data.id})
      end
    end
  end
end

-- Function to remove an option set from a group and restore original options
function M.remove_option_set(group_name, set_name)
  if M.window_groups[group_name] and M.option_sets[set_name] then
    for _, window_data in ipairs(M.window_groups[group_name]) do
      M.restore_window_options(window_data.id, window_data.saved_options)
    end
  end
end

-- Function to save all window-local options for a given window
function M.save_window_options(win_id)
  local saved_options = {}
  local all_options = vim.api.nvim_get_all_options_info()

  for option_name, option_info in pairs(all_options) do
    if option_info.scope == "win" then
      saved_options[option_name] = vim.api.nvim_get_option_value(option_name, {win = win_id})
    end
  end

  return saved_options
end

-- Function to restore saved window options
function M.restore_window_options(win_id, saved_options)
  for option_name, value in pairs(saved_options) do
    vim.api.nvim_set_option_value(option_name, value, {win = win_id})
  end
end

return M
