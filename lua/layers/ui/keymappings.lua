local cosmos = require('core.cosmos')

cosmos.add_leader_keymapping('n|tp', { ':lua require("layers.ui.functions").pick_theme()<CR>', name = 'Theme pick' })
cosmos.add_leader_keymapping(
  'n|tt',
  { ':lua require("layers.ui.functions").toggle_theme_preview("oneview")<CR>', name = 'Theme toggle' }
)
