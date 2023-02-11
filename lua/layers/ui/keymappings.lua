local cosmos = require('core.cosmos')

cosmos.add_leader_keymapping('n|tp', { ':lua require("layers.ui.functions").pick_theme()<CR>', name = 'Theme pick' })
