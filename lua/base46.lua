local M = {}

M.get_theme_tb = function(type)
  return require('layers.ui.colors').get()[type]
end

-- a dummy method to compatibilize with NvChad/base46
M.override_theme = function(default_theme, theme_name)
  return default_theme
end

return M
