local utils = require('utils')

vim.cmd [[
function! Home()
  let start_col = col('.')
  normal! ^
  if col('.') == start_col
    normal! 0
  endif
  return ''
endfunction

function! KillLine()
  let [text_before_cursor, text_after_cursor] = SplitLineTextAtCursor()
  if len(text_after_cursor) == 0
    normal! J
  else
    call setline(line('.'), text_before_cursor)
  endif
  return ''
endfunction

function! SplitLineTextAtCursor()
  let line_text = getline(line('.'))
  let text_after_cursor  = line_text[col('.')-1 :]
  let text_before_cursor = (col('.') > 1) ? line_text[: col('.')-2] : ''
  return [text_before_cursor, text_after_cursor]
endfunction
]]

local M = {}

function M.find_current_directory_files()
  local dir = vim.fn.expand('%:p:h')
  if dir == "" then
    dir = vim.fn.getcwd()
  end
  utils.safe_require('telescope.builtin', function(telescope)
    telescope.find_files{
      search_dirs = { dir },
    }
  end)
end

function M.edit_neovim()
  utils.safe_require('telescope.builtin', function(telescope)
    telescope.find_files{
      shorten_path = true,
      cwd = '~/.config/nvim',
      prompt_title = "~ dotfiles ~",
    }
  end)
end

function M.reload_configuration()
  utils.reload('plugins')
  utils.reload('functions')
  utils.reload('settings')
  utils.reload('config')
  utils.reload('mappings')
end

M.commands = function(opts)
  opts = opts or {}
  utils.safe_require({'telescope.builtin', 'plenary.context_manager'}, function(_, context_manager)
    local with = context_manager.with
    local open = context_manager.open
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local finders = require "telescope.finders"
    local make_entry = require "telescope.make_entry"
    local pickers = require "telescope.pickers"

    local conf = require("telescope.config").values

    local directory = string.format("%s/site/", vim.fn.stdpath("data"))
    vim.fn.mkdir(directory, "p")
    local history_filepath = directory .. "nvim_commands_history.txt"

    local history_content = ''
    local history_file = io.open(history_filepath, "r")
    if history_file then
      history_content = history_file:read("*all")
      history_file:close()
    else
      local _f = io.open(history_filepath, "w")
      _f:write(history_content)
      _f:close()
    end

    local history_lines = vim.split(history_content, "\n")

    local max_line = 10

    if #history_lines > max_line then
      history_lines = vim.list_slice(history_lines, #history_lines - max_line, #history_lines)
    end

    pickers.new(opts, {
      prompt_title = "Commands",
      finder = finders.new_table {
        results = (function()
          local command_iter = vim.api.nvim_get_commands {}
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
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          if selection == nil then
            print "[telescope] Nothing currently selected"
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
            f:write(table.concat(result, "\n"))
          end)

          if val.nargs == "0" then
            vim.cmd(cmd)
          else
            vim.cmd [[stopinsert]]
            vim.fn.feedkeys(cmd)
          end
        end)

        return true
      end,
    }):find()
  end)
end

return M

