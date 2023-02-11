local stdpath = vim.fn.stdpath

return {
  user_config_path = vim.fn.expand('$HOME/.cosmos-nvim.lua'),
  cosmos_configs_root = stdpath('config'),

  python3_host_prog = '~/.pyenv/versions/nvim-py3/bin/python',

  helix_mode = false,
}
