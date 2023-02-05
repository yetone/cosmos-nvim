local home = function()
  local start_col = vim.fn.col "."
  vim.cmd "normal! ^"
  if vim.fn.col "." == start_col then
    vim.cmd "normal! 0"
  end
  return ""
end

local split_line_text_at_cursor = function ()
  local line_text = vim.fn.getline(vim.fn.line ".")
  local text_after_cursor = line_text:sub(vim.fn.col "." - 1)
  local text_before_cursor = (vim.fn.col "." > 1) and line_text:sub(1, vim.fn.col "." - 2) or ""
  return {text_before_cursor, text_after_cursor}
end

local kill_line = function()
  local text_before_cursor, text_after_cursor = split_line_text_at_cursor()
  if #text_after_cursor == 0 then
    vim.cmd "normal! J"
  else
    vim.fn.setline(vim.fn.line ".", text_before_cursor)
  end
  return ""
end

if vim.fn.has("nvim-0.8") == 1 then
  vim.api.nvim_create_user_command("Home", home, {})
  vim.api.nvim_create_user_command("SplitLineTextAtCursor", split_line_text_at_cursor, {})
  vim.api.nvim_create_user_command("KillLine", kill_line, {})
else
  -- keep vimscript as fallback for nvim < 0.8
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
end
