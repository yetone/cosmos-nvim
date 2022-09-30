vim.cmd [[
command Format :lua vim.lsp.buf.formatting()
]]

local function copy(sel)
  return function()
    local content = table.concat(vim.v.event.regcontents, '\n')
    local encoded_content = vim.fn.system('base64', content)
    local osc = '\027]52;' .. sel .. ';' .. encoded_content .. '\a'
    if vim.fn.filewritable('/dev/fd/2') then
      vim.fn.writefile({osc}, '/dev/fd/2', 'b')
    else
      vim.fn.chansend(vim.v.stderr, osc)
    end
  end
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankOSC52", { clear = true }),
  pattern = "*",
  callback = function()
    copy('c')()
  end,
})
