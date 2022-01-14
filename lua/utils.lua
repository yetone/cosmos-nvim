local M = {}

local function is_module_available(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

function M.safe_require(pkg_name, cbk)
  local pkg_names = {}
  if type(pkg_name) == 'table' then
    pkg_names = pkg_name
  else
    pkg_names = { pkg_name }
  end

  local pkgs = {}
  for i, pkg_name_ in ipairs(pkg_names) do
    if is_module_available(pkg_name_) then
      pkgs[i] = require(pkg_name_)
    else
      print('WARNING: package ' .. pkg_name_ .. ' is not found')
      return
    end
  end

  return cbk(unpack(pkgs))
end

function M.index_of(tbl, val, cmp)
  cmp = cmp or function(a, b) return a == b end
  for i, v in ipairs(tbl) do
    if cmp(v, val) then
      return i
    end
  end
  return -1
end

function M.reload(module)
  return M.safe_require('plenary.reload', function(plenary)
    plenary.reload_module(module)
    require(module)
  end)
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local _user_config

local function get_user_config()
  if _user_config then
    return _user_config
  end
  local ok
  ok, _user_config = pcall(dofile, require('config').user_config_path)
  if not ok then
    if not string.find(_user_config, 'No such file or directory') then
      print('WARNING: user config file is invalid')
      print(_user_config)
    end
    _user_config = nil
  end
  if _user_config == nil then
    _user_config = {}
  end
  if _user_config.config == nil then
    _user_config.config = {}
  end
  if _user_config.setup_settings == nil then
    _user_config.setup_settings = function()
    end
  end
  if _user_config.setup_mappings == nil then
    ---@diagnostic disable-next-line: unused-local
    _user_config.setup_mappings = function(wk)
    end
  end
  if _user_config.setup_plugins == nil then
    ---@diagnostic disable-next-line: unused-local
    _user_config.setup_plugins= function(use)
    end
  end
  return _user_config
end

function M.reset_user_config()
  _user_config = nil
end

function M.startup()
  M.fill_config()
  require('plugins')
  require('functions')
  require('settings')
  require('mappings')
end

function M.restartup()
  M.reset_user_config()
  M.fill_config()
  M.reload('plugins')
  M.reload('functions')
  M.reload('settings')
  M.reload('mappings')
  require('packer').compile()
end

function M.fill_config()
  local user_config = get_user_config()
  local config = require('config')
  config.cosmos = vim.tbl_deep_extend('force', config.cosmos, user_config.config)
end

function M.setup_user_settings()
  get_user_config().setup_settings()
end

function M.setup_user_mappings(wk)
  get_user_config().setup_mappings(wk)
end

function M.setup_user_plugins(use)
  get_user_config().setup_plugins(use)
end

return M
