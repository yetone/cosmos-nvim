local cosmos = require('core.cosmos')
local editor_options = require('layers.editor.options')

cosmos.add_leader_keymapping('n|gs', { ':lua require("neogit").open()<CR>', name = 'Magit status' })
cosmos.add_leader_keymapping('n|gi', {
  ":lua require('telescope').extensions.gh.issues(require('telescope.themes').get_"
    .. editor_options.telescope_theme
    .. '({}))<cr>',
  name = 'GitHub issues',
})
cosmos.add_leader_keymapping('n|gp', {
  ":lua require('telescope').extensions.gh.pull_request(require('telescope.themes').get_"
    .. editor_options.telescope_theme
    .. '({}))<cr>',
  name = 'GitHub pull requests',
})
cosmos.add_leader_keymapping('n|gg', {
  ":lua require('telescope').extensions.gh.gist(require('telescope.themes').get_"
    .. editor_options.telescope_theme
    .. '({}))<cr>',
  name = 'GitHub gists',
})
cosmos.add_leader_keymapping('n|gw', {
  ":lua require('telescope').extensions.gh.run(require('telescope.themes').get_"
    .. editor_options.telescope_theme
    .. '({}))<cr>',
  name = 'GitHub workflows',
})
