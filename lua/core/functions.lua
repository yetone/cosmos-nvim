-- keep vimscript as fallback for nvim < 0.8
vim.cmd([[
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
]])
