vim.cmd [[
command Format :lua vim.lsp.buf.formatting()

function Copy()
  let c = join(v:event.regcontents,"\n")
  let c64 = system("base64", c)
  let s = "\e]52;c;" . trim(c64) . "\x07"
  call chansend(v:stderr, s)
endfunction

autocmd TextYankPost * call Copy()
]]
