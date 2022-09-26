local utils = require('core.utils')
local nvim_configs_dir = vim.fn.stdpath('config')
local lua_dir = nvim_configs_dir .. '/lua'
local layers_dir = lua_dir .. '/layers'
local private_layers_dir = lua_dir .. '/private/layers'
local current_layer_name = nil

---@diagnostic disable-next-line: unused-function, unused-local
local function list_all_layer_module_names(filename)
  local list = {}
  for _, dir in ipairs({layers_dir, private_layers_dir}) do
    local tmp = vim.split(vim.fn.globpath(dir, "*/" .. filename), "\n")
    for _, f in ipairs(tmp) do
      local m = f:sub(#lua_dir + 1, -1)
      list[#list + 1] = m:sub(0, #m - 4)
    end
  end
  return list
end

local function fill_layer_options()
  local user_config = utils.get_user_config()
  for _, layer in ipairs(user_config.layers) do
    for _, dir in ipairs({layers_dir, private_layers_dir}) do
      ---@diagnostic disable-next-line: undefined-field
      local f = dir .. '/' .. layer.name .. '/options.lua'
      if not utils.file_exists(f) then
        goto continue
      end
      local m = f:sub(#lua_dir + 1, -1)
      local module_name = m:sub(2, #m - 4)
      module_name = module_name:gsub('/', '.')
      local options = require(module_name)
      ---@diagnostic disable-next-line: undefined-field
      utils.fill_options(options, layer.options)
      ::continue::
    end
  end
end

local function execute_layer_settings()
  local user_config = utils.get_user_config()
  for _, layer in ipairs(user_config.layers) do
    for _, dir in ipairs({layers_dir, private_layers_dir}) do
      ---@diagnostic disable-next-line: undefined-field
      local f = dir .. '/' .. layer.name .. '/settings.lua'
      if not utils.file_exists(f) then
        goto continue
      end
      dofile(f)
      ::continue::
    end
  end
end

local function list_layer_module_names(filename)
  local user_config = utils.get_user_config()
  local list = {}
  for _, layer in ipairs(user_config.layers) do
    for _, dir in ipairs({layers_dir, private_layers_dir}) do
      ---@diagnostic disable-next-line: undefined-field
        local f = dir .. '/' .. layer.name .. '/' .. filename
        if not utils.file_exists(f) then
          goto continue
        end
        exists = true
        local m = f:sub(#lua_dir + 1, -1)
        list[#list + 1] = {
          ---@diagnostic disable-next-line: undefined-field
          layer_name = layer.name,
          module_name = m:sub(0, #m - 4),
        }
      ::continue::
    end
  end
  return list
end

local leader_keymappings = {}
local plugins = {}
local plugins_seen = {}

local M = {}

function M.load_packer()
  local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
  local packer_bootstrap = nil

  if not packer_exists then
    if vim.fn.input("Download Packer? (y for yes) ") ~= "y" then
      print('Please install Packer first!')
      return false
    end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    print(" Downloading packer.nvim...")
    local install_path = directory .. "/packer.nvim"
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print(packer_bootstrap)

    vim.cmd [[packadd packer.nvim]]
  end

  return packer_bootstrap
end

function M.add_leader_keymapping(shortcut, opts)
  opts = opts or {}
  local name = opts.name or opts[2]
  if name == nil then
    error(string.format('Missing name for layer %s keymapping %s', current_layer_name, shortcut))
  end
  if current_layer_name ~= nil then
    opts.name = string.format('%s [%s]', name, current_layer_name)
  else
    opts.name = name
  end
  leader_keymappings[shortcut] = opts
end

function M.add_plugin(name, opts)
  if plugins_seen[name] then
    print(string.format('[Warning] Plugin %s already added!', name))
    return
  end
  plugins[#plugins + 1] = vim.tbl_extend('force', { name }, opts or {})
  plugins_seen[name] = true
end

local function load_layer_keymappings()
  for _, m in ipairs(list_layer_module_names('keymappings.lua')) do
    current_layer_name = m.layer_name
    require(m.module_name)
    current_layer_name = nil
  end
end

local function load_layer_plugins()
  for _, m in ipairs(list_layer_module_names('plugins.lua')) do
    current_layer_name = m.layer_name
    require(m.module_name)
    current_layer_name = nil
  end
end

local default_leader_keymapping_group_names = {
  w = {
    name = '+Windows',
  },
  d = {
    name = '+Debug',
  },
  b = {
    name = '+Buffers',
  },
  f = {
    name = '+Files',
    e = {
      name = 'Config files',
    }
  },
  p = {
    name = '+Projects',
  },
  j = {
    name = '+Jump',
  },
  s = {
    name = '+Search/Symbols',
  },
  g = {
    name = '+Git',
  },
  e = {
    name = '+Errors',
  },
  [';'] = {
    name = 'Comment',
  },
  ["'"] = { name = 'Open shell' },
  ['*'] = { name = 'Search reference in current project' },
  ['/'] = { name = 'Search string in project' },
  ['<Tab>'] = { name = 'Last buffer' },
  ['<Space>'] = { name = 'Commands' },
}

function M.setup_keymappings(enable_which_key)
  load_layer_keymappings()
  local _leader_keymappings = {}
  for shortcut, opts in pairs(leader_keymappings) do
    local mode, keymap = shortcut:match("([^|]*)|?(.*)")
    if not enable_which_key then
      utils.set_keymap(mode, keymap, opts[1], opts)
      goto continue
    end
    opts.mode = mode
    local keys = {}
    local chars = vim.split(keymap, '')
    local in_special_key = false
    local special_key_start_at = 0
    for idx, char in ipairs(chars) do
      if char == '<' then
        in_special_key = true
        special_key_start_at = idx
      elseif char == '>' then
        in_special_key = false
        keys[#keys + 1] = table.concat(chars, '', special_key_start_at, idx)
      elseif not in_special_key then
        keys[#keys + 1] = char
      end
    end
    local group = _leader_keymappings
    local name_group = default_leader_keymapping_group_names
    for idx, key in ipairs(keys) do
      local current_group = group[key] or {}
      local current_name_group = name_group[key] or {}
      current_group.name = current_group.name or current_name_group.name
      if idx == #keys then
        current_group = opts
        current_group[2] = current_group.name
        current_group.name = nil
      end
      group[key] = current_group
      group = current_group
      name_group = current_name_group
    end
    ::continue::
  end
  if enable_which_key then
    local has_wk, wk = pcall(require, 'which-key')
    if has_wk then
      wk.register(_leader_keymappings, { prefix = '<leader>' })
    else
      print('which-key not installed')
    end
  end
end

local function setup_plugins()
  load_layer_plugins()
  local packer_bootstrap = M.load_packer()
  -- packer_bootstrap is nil if the packer.nvim was already installed, so cannot use if not packer_bootstrap to instead of if packer_bootstrap == false
  if packer_bootstrap == false then
    return
  end
  local packer = require('packer')
  if os.getenv('COSMOS_BUILD_IMG') == nil then
    packer.init({
      max_jobs=50
    })
  end
  packer.reset()
  packer.startup(function(use)
    use {
      'lewis6991/impatient.nvim',
      -- rocks = 'mpack'
    }

    use {
      'wbthomason/packer.nvim',
      event = "VimEnter",
    }

		-- use 'nathom/filetype.nvim'

    use 'nvim-lua/plenary.nvim'

    use {
      'antoinemadec/FixCursorHold.nvim', -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
      event = "VimEnter",
    }

    use {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          -- Animation style (see below for details)
          stages = "fade_in_slide_out",

          -- Function called when a new window is opened, use for changing win settings/config
          on_open = nil,

          -- Function called when a window is closed
          on_close = nil,

          -- Render function for notifications. See notify-render()
          render = "default",

          -- Default timeout for notifications
          timeout = 5000,

          -- For stages that change opacity this is treated as the highlight behind the window
          -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
          background_colour = "Normal",

          -- Minimum width for notification windows
          minimum_width = 50,

          -- Icons for the different levels
          icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
          },
        })
      end,
      event = "BufRead",
    }

    for _, opts in ipairs(plugins) do
      if os.getenv('COSMOS_BUILD_IMG') ~= nil then
        opts.event = nil
      end
      use(opts)
    end

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end)
end

local function setup()
  local user_config = utils.get_user_config()
  user_config.before_setup()

  fill_layer_options()
  execute_layer_settings()

  M.add_plugin(
    'folke/which-key.nvim',
    {
      config = function()
        require('which-key').setup({
          plugins = {
            marks = false,
            registers = false,
            presets = {
              operators = false,
              motions = true,
              text_objects = true,
              windows = true,
              nav = true,
              z = true,
              g = true,
            },
          },
          icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
          },
          key_labels = {
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
          },
          window = {
            padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
            border = "none",
          },
          layout = {
            height = { min = 1, max = 10 }, -- min and max height of the columns
            spacing = 3,
            align = "left",
          },
          ignore_missing = true,
          hidden = {
            "<silent>",
            "<Cmd>",
            "<cmd>",
            "<Plug>",
            "call",
            "lua",
            "^:",
            "^ ",
          }, -- hide mapping boilerplate
          show_help = true, -- show help message on the command line when the popup is visible
          triggers = "auto", -- automatically setup triggers
        })
        require('core.cosmos').setup_keymappings(true)
      end,
    }
  )
  setup_plugins()

  user_config.after_setup()
end

function M.startup()
  local user_config = utils.get_user_config()
  local options = require('core.options')
  utils.fill_options(options, user_config.options)
  require('core.functions')
  require('core.settings')
  require('core.keymappings')
  setup()
end

function M.restartup()
  leader_keymappings = {}
  plugins = {}
  plugins_seen = {}
  utils.reset_user_config()
  M.startup()
  require('packer').sync()
end

return M
