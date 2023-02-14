local utils = require('core.utils')
local cosmos = require('core.cosmos')

local M = {}

function M.find_current_directory_files()
  local dir = vim.fn.expand('%:p:h')
  if dir == '' then
    dir = vim.fn.getcwd()
  end
  local opts = require('telescope.themes').get_ivy({})
  opts = vim.tbl_extend('force', opts, {
    path = dir,
    prompt_title = 'Files in ' .. dir,
  })
  require('telescope').extensions.file_browser.file_browser(opts)
end

function M.edit_neovim()
  local telescope = require('telescope.builtin')
  telescope.find_files({
    shorten_path = true,
    cwd = require('core.options').cosmos_configs_root,
    prompt_title = '~ dotfiles ~',
  })
end

function M.reload_configuration()
  cosmos.restartup()
  print('reloaded')
end

M.commands = function(opts)
  opts = opts or {}
  local context_manager = require('plenary.context_manager')
  local with = context_manager.with
  local open = context_manager.open
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local finders = require('telescope.finders')
  local make_entry = require('telescope.make_entry')
  local pickers = require('telescope.pickers')

  local conf = require('telescope.config').values

  local directory = string.format('%s/site/', vim.fn.stdpath('data'))
  vim.fn.mkdir(directory, 'p')
  local history_filepath = directory .. 'nvim_commands_history.txt'

  local history_content = ''
  local history_file = io.open(history_filepath, 'r')
  if history_file then
    history_content = history_file:read('*all')
    history_file:close()
  else
    local _f = io.open(history_filepath, 'w')
    if _f then
      _f:write(history_content)
      _f:close()
    end
  end

  local history_lines = vim.split(history_content, '\n')

  local max_line = 10

  if #history_lines > max_line then
    history_lines = vim.list_slice(history_lines, #history_lines - max_line, #history_lines)
  end

  pickers
    .new(opts, {
      prompt_title = 'Commands',
      finder = finders.new_table({
        results = (function()
          local command_iter = vim.api.nvim_get_commands({})
          local commands = {}

          for _, cmd in pairs(command_iter) do
            table.insert(commands, cmd)
          end

          local cmp = function(a, b)
            if a == nil or b == nil then
              return false
            end
            return string.lower(a) == string.lower(b)
          end

          table.sort(commands, function(a, b)
            return utils.index_of(history_lines, a.name, cmp) > utils.index_of(history_lines, b.name, cmp)
          end)

          return commands
        end)(),

        entry_maker = opts.entry_maker or make_entry.gen_from_commands(opts),
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          if selection == nil then
            print('[telescope] Nothing currently selected')
            return
          end

          actions.close(prompt_bufnr)

          local val = selection.value
          local cmd = string.format([[:%s ]], val.name)

          local result = {}

          for _, v in ipairs(history_lines) do
            if string.lower(v) ~= string.lower(val.name) then
              table.insert(result, v)
            end
          end

          table.insert(result, val.name)

          with(open(history_filepath, 'w'), function(f)
            f:write(table.concat(result, '\n'))
          end)

          if val.nargs == '0' then
            vim.cmd(cmd)
          else
            vim.cmd([[stopinsert]])
            vim.fn.feedkeys(cmd)
          end
        end)

        return true
      end,
    })
    :find()
end

local dap_unmap = function()
  local keys = {
    'r',
    'c',
    'n',
    's',
    'o',
    'S',
    'u',
    'D',
    'C',
    'b',
    'P',
    'p',
    'K',
    'B',
    'R',
    'O',
    'a',
    'w',
  }
  for _, value in pairs(keys) do
    local cmd = 'silent! unmap ' .. value
    vim.cmd(cmd)
  end

  vim.cmd([[silent! vunmap p]])
end

local function dap_keybind()
  local set_keymap = vim.api.nvim_set_keymap
  set_keymap('n', 'b', "<CMD>lua require('dap').toggle_breakpoint()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'P', "<CMD>lua require('dap').pause()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'K', "<CMD>lua require('dapui').float_element()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'R', "<CMD>lua require('dapui').float_element('repl')<CR>", { silent = true, noremap = true })
  set_keymap('n', 'n', "<CMD>lua require('dap').step_over()<CR>", { silent = true, noremap = true })
  set_keymap('n', 's', "<CMD>lua require('dap').step_into()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'o', "<CMD>lua require('dap').step_out()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'c', "<CMD>lua require('dap').continue()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'r', "<CMD>lua require('layers.editor.functions').run_dap()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'S', "<CMD>lua require('layers.editor.functions').stop_dap()<CR>", { silent = true, noremap = true })
  set_keymap('n', 't', "<CMD>lua require('dapui').toggle()<CR>", { silent = true, noremap = true })
  set_keymap('n', 'C', "<CMD>lua require('dapui').close()<CR>", { silent = true, noremap = true })
end

M.run_dap = function()
  require('dap.ext.vscode').load_launchjs()
  -- dap_keybind()
  require('dap').continue()
  require('dapui').open()
end

M.stop_dap = function()
  -- dap_unmap()

  local has_dap, dap = pcall(require, 'dap')
  if has_dap then
    require('dap').disconnect()
    require('dap').close()
    require('dap').repl.close()
  end
  local has_dapui, dapui = pcall(require, 'dapui')
  if has_dapui then
    dapui.close()
  end
end

function M.open_lua_repl()
  -- get current buffer and window
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  -- create a new split for the repl
  vim.cmd('split')
  -- spawn repl and set the context to our buffer
  require('neorepl').new({
    lang = 'vim',
    buffer = buf,
    window = win,
  })
  -- resize repl window and make it fixed height
  vim.cmd('resize 10 | setl winfixheight')
end

function M.goto_prev_node()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return
  end
  local dest_node = ts_utils.get_previous_node(node, true, true)
  if not dest_node then
    local cur_node = node:parent()
    while cur_node do
      dest_node = ts_utils.get_previous_node(cur_node, false, false)
      if dest_node then
        break
      end
      cur_node = cur_node:parent()
    end
  end
  if not dest_node then
    return
  end
  ts_utils.goto_node(dest_node)
end

function M.goto_next_node()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return
  end
  local dest_node = ts_utils.get_next_node(node, true, true)
  if not dest_node then
    local cur_node = node:parent()
    while cur_node do
      dest_node = ts_utils.get_next_node(cur_node, false, false)
      if dest_node then
        break
      end
      cur_node = cur_node:parent()
    end
  end
  if not dest_node then
    return
  end
  ts_utils.goto_node(dest_node)
end

function M.goto_parent_node()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return
  end
  local dest_node = node:parent()
  if not dest_node then
    return
  end
  ts_utils.goto_node(dest_node)
end

function M.goto_child_node()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return
  end
  local dest_node = ts_utils.get_named_children(node)[1]
  if not dest_node then
    return
  end
  ts_utils.goto_node(dest_node)
end

return M
