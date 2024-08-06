local utils = require('layers.ui.utils')
local configs = {}

function configs.web_devicons()
  local web_devicons = require('nvim-web-devicons')
  local colors = require('layers.ui.colors').get()
  web_devicons.setup({
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = '',
        color = '#428850',
        cterm_color = '65',
        name = 'Zsh',
      },
      c = {
        icon = '',
        color = colors.blue,
        name = 'c',
      },
      css = {
        icon = '',
        color = colors.blue,
        name = 'css',
      },
      deb = {
        icon = '',
        color = colors.cyan,
        name = 'deb',
      },
      Dockerfile = {
        icon = '',
        color = colors.cyan,
        name = 'Dockerfile',
      },
      html = {
        icon = '',
        color = colors.baby_pink,
        name = 'html',
      },
      jpeg = {
        icon = '',
        color = colors.dark_purple,
        name = 'jpeg',
      },
      jpg = {
        icon = '',
        color = colors.dark_purple,
        name = 'jpg',
      },
      js = {
        icon = '',
        color = colors.sun,
        name = 'js',
      },
      kt = {
        icon = '󱈙',
        color = colors.orange,
        name = 'kt',
      },
      lock = {
        icon = '',
        color = colors.red,
        name = 'lock',
      },
      lua = {
        icon = '',
        color = colors.blue,
        name = 'lua',
      },
      mp3 = {
        icon = '',
        color = colors.white,
        name = 'mp3',
      },
      mp4 = {
        icon = '',
        color = colors.white,
        name = 'mp4',
      },
      out = {
        icon = '',
        color = colors.white,
        name = 'out',
      },
      png = {
        icon = '󰉏',
        color = colors.dark_purple,
        name = 'png',
      },
      py = {
        icon = '',
        color = colors.cyan,
        name = 'py',
      },
      ['robots.txt'] = {
        icon = '󰚩',
        color = colors.red,
        name = 'robots',
      },
      toml = {
        icon = '',
        color = colors.blue,
        name = 'toml',
      },
      ts = {
        icon = '󰛦',
        color = colors.teal,
        name = 'ts',
      },
      ttf = {
        icon = '',
        color = colors.white,
        name = 'TrueTypeFont',
      },
      rb = {
        icon = '',
        color = colors.pink,
        name = 'rb',
      },
      rpm = {
        icon = '',
        color = colors.orange,
        name = 'rpm',
      },
      vue = {
        icon = '',
        color = colors.vibrant_green,
        name = 'vue',
      },
      woff = {
        icon = '',
        color = colors.white,
        name = 'WebOpenFontFormat',
      },
      woff2 = {
        icon = '',
        color = colors.white,
        name = 'WebOpenFontFormat2',
      },
      xz = {
        icon = '',
        color = colors.sun,
        name = 'xz',
      },
      zip = {
        icon = '',
        color = colors.sun,
        name = 'zip',
      },
    },
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
  })
end

function configs.dashboard()
  local home = os.getenv('HOME')
  local db = require('dashboard')
  db.setup({
    theme = 'doom',
    config = {
      footer = { utils.get_quote() },
      center = {
        {
          icon = '  ',
          desc = 'List Projects',
          action = 'Telescope projects',
          shortcut = 'SPC p p',
        },
        {
          icon = '  ',
          desc = 'Recent Files',
          -- action = 'Telescope old_files',
          action = "lua require('layers.editor.functions').find_current_directory_files()",
          shortcut = 'SPC f f',
        },
        {
          icon = '  ',
          desc = 'Find File',
          action = 'Telescope find_files',
          shortcut = 'SPC f f',
        },
        {
          icon = '󰊄  ',
          desc = 'Find Text',
          action = 'Telescope live_grep',
          shortcut = 'SPC /  ',
        },
      },
    },
    preview = {
      command = 'chafa --passthrough tmux -f symbols -s 60x60 -c full --fg-only --symbols braille --clear',
      -- file_path = '$(ls ' .. home .. '/.config/nvim/static/*.gif | sort -R)',
      file_path = home .. '/.config/nvim/static/dashboard.gif',
      file_height = 24,
      file_width = 64,
    },
  })
end

function configs.lualine()
  local lualine = require('lualine')
  local options = require('layers.ui.options')

  local function window()
    return vim.api.nvim_win_get_number(0)
  end

  local config = {
    options = {
      disabled_filetypes = options.statusline_filetype_exclude,
      icons_enabled = true,
      theme = require('layers.ui.highlights').get_lualine_theme(),
      component_separators = '|',
      section_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
      },
      lualine_b = { 'branch', 'diff', 'diagnostics', 'filename' },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { 'encoding', 'fileformat', 'filetype', 'progress' },
      lualine_z = {
        { 'location', separator = { left = '', right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {
        { window, separator = { left = '', right = '' }, right_padding = 2 },
      },
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = {
        { 'location', separator = { left = '', right = '' }, left_padding = 2 },
      },
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }

  local has_navic = pcall(require, 'nvim-navic')
  if has_navic then
    local component = { 'navic' }
    if require('core.utils').index_of(config.sections.lualine_b, component) < 0 then
      table.insert(config.sections.lualine_b, component)
    end
  end

  lualine.setup(config)
end

function configs.fidget()
  local fidget = require('fidget')
  fidget.setup({
    progress = {
      display = {
        progress_icon = {
          pattern = 'moon',
          period = 1,
        },
      },
    },
  })
end

function configs.get_bufferline_options()
  local default = {
    colors = require('layers.ui.colors').get().base_30,
  }

  return {
    options = {
      always_show_bufferline = false,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
          s = s .. n .. sym
        end
        return s
      end,
      offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
    },

    highlights = {
      background = {
        fg = default.colors.grey_fg,
        bg = default.colors.black2,
      },

      -- buffers
      buffer_selected = {
        fg = default.colors.white,
        bg = default.colors.black,
        bold = true,
      },
      buffer_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },

      -- for diagnostics = "nvim_lsp"
      diagnostic = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      hint = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      hint_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      hint_diagnostic = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      hint_diagnostic_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      info = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      info_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      info_diagnostic = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      info_diagnostic_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      error = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      error_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      error_diagnostic = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      error_diagnostic_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      warning = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      warning_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      warning_diagnostic = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      warning_diagnostic_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },

      buffer = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },

      numbers = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },

      numbers_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },

      duplicate = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },

      duplicate_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black,
      },

      -- close buttons
      close_button = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      close_button_visible = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      close_button_selected = {
        fg = default.colors.red,
        bg = default.colors.black,
      },
      fill = {
        fg = default.colors.grey_fg,
        bg = default.colors.black2,
      },
      indicator_selected = {
        fg = default.colors.black,
        bg = default.colors.black,
      },

      -- modified
      modified = {
        fg = default.colors.red,
        bg = default.colors.black2,
      },
      modified_visible = {
        fg = default.colors.red,
        bg = default.colors.black2,
      },
      modified_selected = {
        fg = default.colors.green,
        bg = default.colors.black,
      },

      -- separators
      separator = {
        fg = default.colors.black2,
        bg = default.colors.black2,
      },
      separator_visible = {
        fg = default.colors.black2,
        bg = default.colors.black2,
      },
      separator_selected = {
        fg = default.colors.black2,
        bg = default.colors.black2,
      },
      tab_separator = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      tab_separator_selected = {
        fg = default.colors.light_grey,
        bg = default.colors.black2,
      },
      group_separator = {
        fg = default.colors.black2,
        bg = default.colors.black2,
      },
      offset_separator = {
        fg = default.colors.black2,
        bg = default.colors.black2,
      },

      -- tabs
      tab = {
        fg = default.colors.light_grey,
        bg = default.colors.one_bg3,
      },
      tab_selected = {
        fg = default.colors.black2,
        bg = default.colors.nord_blue,
      },
      tab_close = {
        fg = default.colors.red,
        bg = default.colors.black,
      },
    },
  }
end

function configs.bufferline()
  local bufferline = require('bufferline')

  bufferline.setup(configs.get_bufferline_options())
end

function configs.neoscroll()
  local neoscroll = require('neoscroll')
  neoscroll.setup()
end

function configs.doom_one()
  local doom_one = require('doom-one')
  doom_one.setup({
    cursor_coloring = true,
    terminal_colors = true,
    italic_comments = true,
    enable_treesitter = true,
    transparent_background = true,
    pumblend = {
      enable = true,
      transparency_amount = 20,
    },
    plugins_integrations = {
      neorg = true,
      barbar = true,
      bufferline = true,
      gitgutter = true,
      gitsigns = true,
      telescope = true,
      neogit = true,
      nvim_tree = true,
      dashboard = true,
      startify = true,
      whichkey = true,
      indent_blankline = true,
      vim_illuminate = true,
      lspsaga = true,
    },
  })
end

function configs.indent_blankline()
  local ibl = require('ibl')
  local options = require('layers.ui.options')

  ibl.setup({
    exclude = {
      filetypes = options.indent_blankline_filetype_exclude,
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = { 'IndentBlanklineContextChar' },
    },
    indent = {
      highlight = { 'IndentBlanklineChar' },
    },
  })
end

function configs.todo_comments()
  local todo_comments = require('todo-comments')
  todo_comments.setup()
end

function configs.colorizer()
  local colorizer = require('colorizer')
  colorizer.setup()
end

function configs.hlslens()
  local hlslens = require('hlslens')
  hlslens.setup()
end

function configs.scrollbar()
  local scrollbar = require('scrollbar')
  require('scrollbar.handlers.search').setup()
  scrollbar.setup()
end

function configs.navic()
  local navic = require('nvim-navic')
  navic.setup({
    lsp = {
      auto_attach = true,
    },
  })
end

function configs.cursorline()
  require('nvim-cursorline').setup({
    cursorline = {
      enable = true,
      timeout = 500,
      number = false,
    },
    cursorword = {
      enable = false,
      min_length = 3,
      hl = { underline = true },
    },
  })
end

function configs.highlight_undo()
  require('highlight-undo').setup({
    duration = 300,
    undo = {
      hlgroup = 'HighlightUndo',
      mode = 'n',
      lhs = 'u',
      map = 'undo',
      opts = {},
    },
    redo = {
      hlgroup = 'HighlightUndo',
      mode = 'n',
      lhs = '<C-r>',
      map = 'redo',
      opts = {},
    },
    highlight_for_count = true,
  })
end

function configs.tailwind_fold()
  require('tailwind-fold').setup({
    enabled = true,
    symbol = '󱏿', -- 󱏿
    highlight = {
      fg = '#38BDF8', -- [[ symbol color ]]
    },
    ft = {
      'html',
      'svelte',
      'astro',
      'vue',
      'tsx',
      'php',
      'blade',
      'eruby',
    },
  })
end

return configs
