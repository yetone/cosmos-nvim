local override = require('layers.ui.options').hl_override
local theme = require('layers.ui.colors').get().base_16
local highlights = {}

local merge_tb = function(table1, table2)
  return vim.tbl_deep_extend('force', table1, table2)
end

local hl_files = vim.fn.stdpath('config') .. '/lua/layers/ui/integrations'

for _, file in ipairs(vim.fn.readdir(hl_files)) do
  local integration = require('layers.ui.integrations.' .. vim.fn.fnamemodify(file, ':r'))
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
