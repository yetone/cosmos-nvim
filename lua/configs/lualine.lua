local utils = require('utils')

utils.safe_require('lualine', function(lualine)
  local colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#080808',
    white  = '#c6c6c6',
    red    = '#ff5189',
    violet = '#d183e8',
    grey   = '#303030',
  }

  local auto_theme = require('lualine.themes.auto')

  auto_theme.normal.c.bg = auto_theme.normal.a.fg

  local config = {
    options = {
      icons_enabled = true,
      theme = auto_theme,
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = {'branch', 'diff', 'diagnostics', 'filename'},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {'encoding', 'fileformat', 'filetype', 'progress'},
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {}
  }

  -- Inserts a component in lualine_b at left section
  local function ins_config_left(component)
    if utils.index_of(config.sections.lualine_b, component) < 0 then
      table.insert(config.sections.lualine_b, component)
    end
  end

  local lsp_progress = require('lualine.components.lsp_progress')

  ins_config_left {
    'lsp_progress',
    display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
    colors = {
      percentage  = colors.cyan,
      title  = colors.cyan,
      message  = colors.cyan,
      spinner = colors.cyan,
      lsp_client_name = colors.magenta,
      use = true,
    },
    separators = {
      component = ' ',
      progress = ' | ',
      percentage = { pre = '', post = '%% ' },
      title = { pre = '', post = ': ' },
      lsp_client_name = { pre = '[', post = ']' },
      spinner = { pre = '', post = '' },
      message = { commenced = 'In Progress', completed = 'Completed' },
    },
    timer = { progress_enddelay = 500, spinner = 500, lsp_client_name_enddelay = 1000 },
    spinner_symbols = lsp_progress.default.spinner_symbols_moon,
  }

  lualine.setup(config)
end)
