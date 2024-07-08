local TeaStore = {}

function TeaStore.setup(config)
    TeaStore.mappingPrefix = config.mappingPrefix or ","
    TeaStore.templateDir = config.templateDir
    TeaStore.templates = {}
    return TeaStore
end

function TeaStore.updateTemplateList()
  local dirHandle = io.popen("ls -1 " .. TeaStore.templateDir)
  local templates = {}
  if dirHandle == nil then
    TeaStore.templates = templates
  end

  local i = 1
  for template in dirHandle:lines() do
    templates[i] = template
    i = i + 1
  end
  dirHandle:close()
  TeaStore.templates = templates
end

function TeaStore.updateTemplateMappings()
  for _, template in ipairs(TeaStore.templates) do
    vim.keymap.set("n", TeaStore.mappingPrefix .. template, function() TeaStore.useTemplate(template) end)
  end
end

function TeaStore.useTemplate(template)
  local path = TeaStore.templateDir
  if string.sub(path, #path) ~= "/" then
    path = path .. "/"
  end
  vim.cmd("-1read " .. path .. template)
end

return TeaStore
