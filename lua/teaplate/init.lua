local TeaDisplay = require("teaplate.display")
local TeaStore = require("teaplate.store")

local M = {
  display = nil,
  config = {}
}

local function selectFromDisplay()
  local idx = M.display:close()
  if idx ~= nil then
    TeaStore.useTemplate(TeaStore.templates[idx])
  end
end

local function openDisplay()
  local display = TeaDisplay:new({
    windowWidth = M.config.windowWidth,
  })
  vim.keymap.set(
    "n",
    "<CR>",
    selectFromDisplay,
    { buffer = display.buffer, silent = true }
  )
  display:open(TeaStore.templates)
  M.display = display
end

local function closeDisplay()
  M.display:close()
  M.display = nil
end

local function createCommands()
  vim.api.nvim_create_user_command(
    "TeaHarvest",
    function()
      TeaStore.updateTemplateList()
      TeaStore.updateTemplateMappings()
    end,
    {}
  )
  vim.api.nvim_create_user_command("TeaAssortment", openDisplay, {})
  vim.api.nvim_create_user_command("HideTeaAssortment", closeDisplay, {})
end

-- @class TeaplateConfig
-- @field mappingPrefix string?
-- @field templateDir string
-- @field windowWidth number?

-- @param config TeaplateConfig
function M.setup(config)
  M.config = config
  TeaStore.setup(config)
  TeaStore.updateTemplateList()
  TeaStore.updateTemplateMappings()
  createCommands()
end

return M
