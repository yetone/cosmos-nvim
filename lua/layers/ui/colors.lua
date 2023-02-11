local M = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
M.setup = function()
  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end
  local options = require('layers.ui.options')
  vim.o.termguicolors = true
  vim.g.colors_name = options.theme

  -- unload to force reload
  package.loaded['layers.ui.highlights' or false] = nil
  -- then load the highlights
  require('layers.ui.highlights').setup()
end

-- returns a table of colors for given or current theme
M.get = function()
  local options = require('layers.ui.options')
  return require('layers.ui.themes.' .. options.theme)
end

return M
