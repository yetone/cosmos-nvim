local cosmos = require('core.cosmos')

return {
  layers = {
    'editor',
    'git',
    'ui',
    'completion',
  },
  options = {
    -- python3_host_prog = '~/.pyenv/versions/nvim-py3/bin/python',
  },
  before_setup = function()
    -- cosmos.add_plugin('wakatime/vim-wakatime')
  end,
  after_setup = function()
    -- cosmos.add_leader_keymapping('n|aw', { '<cmd>WakaTimeToday<cr>', name = 'WakaTime Today' })
  end,
}
