local dap_adapters = {
  go = function(callback, config)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local host = config.host or '127.0.0.1'
    local port = config.port or '38697'
    local addr = string.format('%s:%s', host, port)
    local opts = {
      stdio = { nil, stdout },
      args = { 'dap', '-l', addr },
      detached = true,
    }
    handle, pid_or_err = vim.loop.spawn('dlv', opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(function()
      callback({ type = 'server', host = '127.0.0.1', port = port })
    end, 100)
  end,
}

local dap_configurations = {}

local M = {}

M.add_dap_dapter = function(name, adapter)
  dap_adapters[name] = adapter
end

M.get_dap_adapters = function()
  return dap_adapters
end

M.add_dap_configuration = function(name, config)
  dap_configurations[name] = config
end

M.get_dap_configurations = function()
  return dap_configurations
end

return M
