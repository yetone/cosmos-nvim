local merge_tb = function(table1, table2)
  return vim.tbl_deep_extend('force', table1, table2)
end

local M = {}

function M.setup()
  local override    = require('layers.ui.options').hl_override
  local theme_data  = require('layers.ui.colors').get()
  local theme       = theme_data.base_16
  vim.opt.bg        = theme_data.type or 'dark'

  local highlights = {}
  local hl_dir = vim.fn.stdpath('config') .. '/lua/layers/ui/integrations'
  local files = vim.fn.readdir(hl_dir)
  table.sort(files)  -- 稳定加载顺序（可选）

  for _, file in ipairs(files) do
    if file:match('%.lua$') then
      local pkg = 'layers.ui.integrations.' .. vim.fn.fnamemodify(file, ':r')
      package.loaded[pkg] = nil
      local ok, mod = pcall(require, pkg)
      if ok and type(mod) == 'table' then
        highlights = merge_tb(highlights, mod)
      end
    end
  end

  local function looks_like_opts(t)
    if type(t) ~= 'table' then return false end
    for k, _ in pairs(t) do
      if k == 'fg' or k == 'bg' or k == 'sp' or k == 'link'
         or k == 'bold' or k == 'italic' or k == 'underline'
         or k == 'undercurl' or k == 'strikethrough' or k == 'blend'
      then return true end
    end
    return false
  end

  -- apply theme-specific polish highlights if provided
  local polish = theme_data.polish_hl
  if type(polish) == 'table' then
    for key, value in pairs(polish) do
      if type(value) == 'table' then
        if looks_like_opts(value) then
          -- 顶层直写：String / "@string" / DiagnosticError 等
          highlights[key] = value
        else
          -- 分组容器：treesitter / syntax / lsp / plugins / ...
          for nested_key, nested_value in pairs(value) do
            if type(nested_value) == 'table' and looks_like_opts(nested_value) then
              highlights[nested_key] = nested_value
            end
          end
        end
      end
    end
  end

  -- 最后再应用用户覆盖，确保最终生效
  if type(override) == 'table' then
    highlights = merge_tb(highlights, override)
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