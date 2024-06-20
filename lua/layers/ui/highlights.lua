local merge_tb = function(table1, table2)
  return vim.tbl_deep_extend('force', table1, table2)
end

local M = {}

function M.setup()
  local override = require('layers.ui.options').hl_override
  local theme = require('layers.ui.colors').get().base_16
  vim.opt.bg = require('layers.ui.colors').get().type
  local highlights = {}
  local hl_files = vim.fn.stdpath('config') .. '/lua/layers/ui/integrations'

  for _, file in ipairs(vim.fn.readdir(hl_files)) do
    local pkg_name = 'layers.ui.integrations.' .. vim.fn.fnamemodify(file, ':r')
    package.loaded[pkg_name or false] = nil
    local integration = require(pkg_name)
    highlights = merge_tb(highlights, integration)
  end

  for hl, col in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, col)
  end

  vim.g.terminal_color_0 = '#' .. theme.base00
  vim.g.terminal_color_1 = '#' .. theme.base08
  vim.g.terminal_color_2 = '#' .. theme.base0B
  vim.g.terminal_color_3 = '#' .. theme.base0A
  vim.g.terminal_color_4 = '#' .. theme.base0D
  vim.g.terminal_color_5 = '#' .. theme.base0E
  vim.g.terminal_color_6 = '#' .. theme.base0C
  vim.g.terminal_color_7 = '#' .. theme.base05
  vim.g.terminal_color_8 = '#' .. theme.base03
  vim.g.terminal_color_9 = '#' .. theme.base08
  vim.g.terminal_color_10 = '#' .. theme.base0B
  vim.g.terminal_color_11 = '#' .. theme.base0A
  vim.g.terminal_color_12 = '#' .. theme.base0D
  vim.g.terminal_color_13 = '#' .. theme.base0E
  vim.g.terminal_color_14 = '#' .. theme.base0C
  vim.g.terminal_color_15 = '#' .. theme.base07

  if #override ~= 0 then
    require(override)
  end
end

function M.get_lualine_theme()
  local colors = require('layers.ui.colors').get().base_30
  local theme = {
    normal = {
      a = { fg = colors.one_bg, bg = colors.green, gui = 'bold' },
      b = { fg = colors.white, bg = colors.one_bg2 },
      c = { guibg = 'NONE' },
      x = { guibg = 'NONE' },
    },
    command = { a = { fg = colors.one_bg, bg = colors.yellow, gui = 'bold' } },
    insert = { a = { fg = colors.one_bg, bg = colors.blue, gui = 'bold' } },
    visual = { a = { fg = colors.one_bg, bg = colors.dark_purple, gui = 'bold' } },
    terminal = { a = { fg = colors.one_bg, bg = colors.cyan, gui = 'bold' } },
    replace = { a = { fg = colors.one_bg, bg = colors.red, gui = 'bold' } },
    inactive = {
      a = { fg = colors.light_grey, bg = colors.one_bg, gui = 'bold' },
      b = { fg = colors.light_grey, bg = colors.one_bg },
      c = { fg = colors.light_grey, bg = colors.one_bg2 },
    },
  }
  return theme
end

return M
