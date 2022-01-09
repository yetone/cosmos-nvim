local vim = vim
local utils = require('utils')

vim.cmd [[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#devicon#vim#grep(initial_command, 1, fzf#devicon#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function! s:guess_project_root()
  return projectroot#guess()
endfunction

command! ProjectFiles execute 'FilesWithDevicons' s:guess_project_root()

function! Home()
  let start_col = col('.')
  normal! ^
  if col('.') == start_col
    normal! 0
  endif
  return ''
endfunction

function! KillLine()
  let [text_before_cursor, text_after_cursor] = s:split_line_text_at_cursor()
  if len(text_after_cursor) == 0
    normal! J
  else
    call setline(line('.'), text_before_cursor)
  endif
  return ''
endfunction

function! s:split_line_text_at_cursor()
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

local reload = function(module)
  return utils.safe_require('plenary.reload', function(plenary)
    plenary.reload_module(module)
    require(module)
  end)
end

function M.reload_configuration()
  reload('plugins')
  reload('functions')
  reload('settings')
  reload('config')
  reload('mappings')
end

return M

