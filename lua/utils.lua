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

local function safe_require(pkg, cbk)
  if is_module_available(pkg) then
    cbk(require(pkg))
  else
    print('WARNING: ' .. pkg .. ' is not found')
  end
end

M.safe_require = safe_require

return M
