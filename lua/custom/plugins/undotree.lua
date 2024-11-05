return {
  'mbbill/undotree',
  config = function()
    if vim.fn.has("persistent_undo") == 1 then
      local target_path = vim.fn.stdpath('cache') .. '/undodir'
      if vim.fn.isdirectory(target_path) == 0 then
        vim.fn.mkdir(target_path, "", 0700)
        vim.fn.setfperm(target_path, "rwx------")  -- Explicitly set permissions
      end
      vim.opt.undodir = target_path
      vim.opt.undofile = true
    end
  end,
}
