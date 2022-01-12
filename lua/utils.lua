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

local user_config

function get_user_config()
  if user_config then
    return user_config
  end
  local ok
  ok, user_config = pcall(dofile, require('config').user_config_path)
  if not ok then
    if not string.find(user_config, 'No such file or directory') then
      print('WARNING: user config file is invalid')
      print(user_config)
    end
    user_config = {}
  end
  if user_config.setup_settings == nil then
    user_config.setup_settings = function()
    end
  end
  if user_config.setup_mappings == nil then
    user_config.setup_mappings = function(wk)
    end
  end
  if user_config.setup_plugins == nil then
    user_config.setup_plugins= function(use)
    end
  end
  return user_config
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
