local TeaDisplay = {
}

TeaDisplay.__index = TeaDisplay

function TeaDisplay:new(config)
  return setmetatable({
    buffer = nil,
    window = nil,
    width = config.windowWidth or 30,
  }, self)
end

function TeaDisplay:open(templates)
  self:close()
  self.buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(self.buffer, 0, -1, true, templates)

  local width = self.width
  self.window = vim.api.nvim_open_win(
    self.buffer, true, {
      relative = "editor",
      title = "Teaplates",
      row = math.floor(((vim.o.lines - #templates) / 2) - 1),
      col = math.floor((vim.o.columns - width) / 2),
      width = width,
      height = #templates,
      border = "single",
    }
  )
end

function TeaDisplay:close()
  local selectedIndex = nil
  if self.window and self.buffer then
    selectedIndex = vim.fn.line(".")
  end

  if self.buffer ~= nil and vim.api.nvim_buf_is_valid(self.buffer) then
    vim.api.nvim_buf_delete(self.buffer, { force = true })
  end

  if self.window ~= nil and vim.api.nvim_win_is_valid(self.window) then
    vim.api.nvim_win_close(self.window, true)
  end

  self.buffer = nil
  self.window = nil
  return selectedIndex
end

return TeaDisplay
