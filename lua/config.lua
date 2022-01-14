return {
  user_config_path = vim.fn.expand('$HOME/.cosmos-nvim.lua'),
  cosmos = {
    enable_beacon = true,
    enable_smooth_scrolling = true,
    enable_rainbow = true,
    python3_host_prog = '~/.pyenv/versions/nvim-py3/bin/python',
    indentLine_fileTypeExclude = { 'alpha' },
    telescope_theme = 'ivy',
  },
}
