local configs = {}

function configs.web_devicons()
  require('core.utils').safe_require('nvim-web-devicons', function(web_devicons)
    local colors = require("layers.ui.colors").get()
    web_devicons.setup {
      -- your personnal icons can go here (to override)
      -- you can specify color or cterm_color instead of specifying both of them
      -- DevIcon will be appended to `name`
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh"
        },
        c = {
          icon = "",
          color = colors.blue,
          name = "c",
        },
        css = {
          icon = "",
          color = colors.blue,
          name = "css",
        },
        deb = {
          icon = "",
          color = colors.cyan,
          name = "deb",
        },
        Dockerfile = {
          icon = "",
          color = colors.cyan,
          name = "Dockerfile",
        },
        html = {
          icon = "",
          color = colors.baby_pink,
          name = "html",
        },
        jpeg = {
          icon = "",
          color = colors.dark_purple,
          name = "jpeg",
        },
        jpg = {
          icon = "",
          color = colors.dark_purple,
          name = "jpg",
        },
        js = {
          icon = "",
          color = colors.sun,
          name = "js",
        },
        kt = {
          icon = "󱈙",
          color = colors.orange,
          name = "kt",
        },
        lock = {
          icon = "",
          color = colors.red,
          name = "lock",
        },
        lua = {
          icon = "",
          color = colors.blue,
          name = "lua",
        },
        mp3 = {
          icon = "",
          color = colors.white,
          name = "mp3",
        },
        mp4 = {
          icon = "",
          color = colors.white,
          name = "mp4",
        },
        out = {
          icon = "",
          color = colors.white,
          name = "out",
        },
        png = {
          icon = "",
          color = colors.dark_purple,
          name = "png",
        },
        py = {
          icon = "",
          color = colors.cyan,
          name = "py",
        },
        ["robots.txt"] = {
          icon = "ﮧ",
          color = colors.red,
          name = "robots",
        },
        toml = {
          icon = "",
          color = colors.blue,
          name = "toml",
        },
        ts = {
          icon = "ﯤ",
          color = colors.teal,
          name = "ts",
        },
        ttf = {
          icon = "",
          color = colors.white,
          name = "TrueTypeFont",
        },
        rb = {
          icon = "",
          color = colors.pink,
          name = "rb",
        },
        rpm = {
          icon = "",
          color = colors.orange,
          name = "rpm",
        },
        vue = {
          icon = "﵂",
          color = colors.vibrant_green,
          name = "vue",
        },
        woff = {
          icon = "",
          color = colors.white,
          name = "WebOpenFontFormat",
        },
        woff2 = {
          icon = "",
          color = colors.white,
          name = "WebOpenFontFormat2",
        },
        xz = {
          icon = "",
          color = colors.sun,
          name = "xz",
        },
        zip = {
          icon = "",
          color = colors.sun,
          name = "zip",
        },
      },
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true;
    }
  end)
end

function configs.alpha()
  require('core.utils').safe_require('alpha', function(alpha)
    math.randomseed(os.time())
    local colors = {'white', 'violet', 'lightyellow'}
    local function random_colors(color_lst)
      return color_lst[math.random(1, #color_lst)]
    end
    vim.cmd(string.format('highlight dashboard guifg=%s guibg=bg', random_colors(colors)))

    local dashboard = require("alpha.themes.dashboard")
    local header = {
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣤⣤⣤⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⢹⣿⣿⡟⡇⠀⠀⢸⠛⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⠸⣿⣿⡇⠁⠀⠀⠘⠀⡿⣿⢿⡿⠸⠃⢻⣿⣿⣿⠃⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⡿⣏⣤⡷⠖⠒⠒⠒⠂⠀⠀⠀⠀⠀⠀⠀⠐⠒⠒⠚⠛⠤⣍⣹⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠿⠈⠁⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⠀⠀⠀⡤⢺⣿⣿⣫⡑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣽⣿⣟⣶⢄⡀⢘⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⡏⠛⡻⠄⠀⠈⠂⠘⣿⣿⠟⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⡛⡘⠃⢼⣷⡻⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣣⣞⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣶⣌⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣯⣾⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠐⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⣿⣿⣿⣿⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠈⠙⠛⠹⠻⠟⠃⠀⠄⠀⠀⠀⠀⠀⠀⠀⢀⠄⠂⢿⠿⡿⣿⢿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣾⠀⠀⠀⠁⠐⠒⠒⠂⠈⠀⠀⠀⣄⣀⠀⠀⠀⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣏⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡆⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⣤⣤⣴⣿⣿⣿⣿⣿⣆⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    }

    dashboard.section.header.val = header
    dashboard.section.header.opts.hl = 'dashboard'

    dashboard.section.buttons.val = {
      dashboard.button("e", "  New File    ", ":enew<CR>"),
      dashboard.button("f", "  Find File   ", ":Telescope find_files<CR>"),
      dashboard.button("t", "  Find Text   ", ":Telescope live_grep<CR>"),
      dashboard.button("c", "  NVIM Config ", ":e ~/.config/nvim/init.lua<CR>:Telescope find_files<CR>"),
      dashboard.button("q", "  Quit        ", ":qa<CR>"),
    }
    alpha.setup(dashboard.opts)
  end)
end

function configs.lualine()
  require('core.utils').safe_require('lualine', function(lualine)
    local options = require('layers.ui.options')
    local auto_theme = require('lualine.themes.auto')

    local function window()
      return vim.api.nvim_win_get_number(0)
    end

    -- auto_theme.normal.c.bg = auto_theme.normal.a.fg

    local config = {
      options = {
        disabled_filetypes = options.statusline_filetype_exclude,
        icons_enabled = true,
        theme = auto_theme,
        component_separators = '|',
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { window, separator = { left = '', right = '', }, right_padding = 2 },
        },
        lualine_b = { 'mode', 'branch', 'diff', 'diagnostics', 'filename'},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {'encoding', 'fileformat', 'filetype', 'progress'},
        lualine_z = {
          { 'location', separator = { left = '', right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {
          { window, separator = { left = '', right = '', }, right_padding = 2 },
        },
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {
          { 'location', separator = { left = '', right = '' }, left_padding = 2 },
        },
        lualine_z = {},
      },
      tabline = {},
      extensions = {}
    }

    local has_gps, gps = pcall(require, 'nvim-gps')
    if has_gps then
      local component = { gps.get_location, cond = gps.is_available }
      if require('core.utils').index_of(config.sections.lualine_b, component) < 0 then
        table.insert(config.sections.lualine_b, component)
      end
    end

    lualine.setup(config)
  end)
end

function configs.fidget()
  require('core.utils').safe_require('fidget', function(fidget)
    fidget.setup({
      text = {
        spinner = 'moon',
      },
    })
  end)
end

function configs.bufferline()
  require('core.utils').safe_require('bufferline', function(bufferline)
    local default = {
      colors = require("layers.ui.colors").get(),
    }

    bufferline.setup{
      options = {
        always_show_bufferline = false,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if context.buffer:current() then
            return ''
          end
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
            or (e == "warning" and " " or "ℹ︎" )
            s = s .. n .. sym
          end
          return s
        end,
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      },

      highlights = {
        background = {
          guifg = default.colors.grey_fg,
          guibg = default.colors.black2,
        },

        -- buffers
        buffer_selected = {
          guifg = default.colors.white,
          guibg = default.colors.black,
          gui = "bold",
        },
        buffer_visible = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },

        -- for diagnostics = "nvim_lsp"
        hint = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        hint_diagnostic = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        hint_diagnostic_visible = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        info = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        info_diagnostic = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        info_diagnostic_visible = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        error = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        error_diagnostic = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        error_diagnostic_visible = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        warning = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        warning_diagnostic = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        warning_diagnostic_visible = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },

        -- close buttons
        close_button = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        close_button_visible = {
          guifg = default.colors.light_grey,
          guibg = default.colors.black2,
        },
        close_button_selected = {
          guifg = default.colors.red,
          guibg = default.colors.black,
        },
        fill = {
          guifg = default.colors.grey_fg,
          guibg = default.colors.black2,
        },
        indicator_selected = {
          guifg = default.colors.black,
          guibg = default.colors.black,
        },

        -- modified
        modified = {
          guifg = default.colors.red,
          guibg = default.colors.black2,
        },
        modified_visible = {
          guifg = default.colors.red,
          guibg = default.colors.black2,
        },
        modified_selected = {
          guifg = default.colors.green,
          guibg = default.colors.black,
        },

        -- separators
        separator = {
          guifg = default.colors.black2,
          guibg = default.colors.black2,
        },
        separator_visible = {
          guifg = default.colors.black2,
          guibg = default.colors.black2,
        },
        separator_selected = {
          guifg = default.colors.black2,
          guibg = default.colors.black2,
        },

        -- tabs
        tab = {
          guifg = default.colors.light_grey,
          guibg = default.colors.one_bg3,
        },
        tab_selected = {
          guifg = default.colors.black2,
          guibg = default.colors.nord_blue,
        },
        tab_close = {
          guifg = default.colors.red,
          guibg = default.colors.black,
        },
      },
    }
  end)
end

function configs.neoscroll()
  require('core.utils').safe_require('neoscroll', function(neoscroll)
    neoscroll.setup()
  end)
end

function configs.doom_one()
  require('core.utils').safe_require('doom-one', function(doom_one)
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
  end)
end

function configs.indent_blankline()
  require('core.utils').safe_require('indent_blankline', function(indent_blankline)
    local options = require('layers.ui.options')

    indent_blankline.setup({
      filetype_exclude = options.indentline_filetype_exclude,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = false,
      context_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
    })
  end)
end

function configs.todo_comments()
  require('core.utils').safe_require('todo-comments', function(todo_comments)
    todo_comments.setup()
  end)
end

function configs.colorizer()
  require('core.utils').safe_require('colorizer', function(colorizer)
    colorizer.setup()
  end)
end

function configs.hlslens()
  require('core.utils').safe_require('hlslens', function(hlslens)
    hlslens.setup()
  end)
end

function configs.scrollbar()
  require('core.utils').safe_require('scrollbar', function(scrollbar)
    require('scrollbar.handlers.search').setup()
    scrollbar.setup()
  end)
end

function configs.gps()
  require('core.utils').safe_require('nvim-gps', function(gps)
    gps.setup()
  end)
end

function configs.onedark()
  require('onedark').setup {
    style = 'darker'
  }
  require('onedark').load()
end

return configs
