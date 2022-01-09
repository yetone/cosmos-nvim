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
      print('WARNING: ' .. pkg_name_ .. ' is not found')
      return
    end
  end

  cbk(unpack(pkgs))
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

return M
