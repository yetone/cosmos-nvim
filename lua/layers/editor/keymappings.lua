local utils = require('core.utils')
local cosmos = require('core.cosmos')
local options = require('layers.editor.options')

cosmos.add_leader_keymapping('n|bb', { "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<cr>", name = 'List buffers' })
cosmos.add_leader_keymapping('n|bn', { ':BufferLineCycleNext<CR>', name = 'Next buffer' })
cosmos.add_leader_keymapping('n|bp', { ':BufferLineCyclePrev<CR>', name = 'Previous buffer' })
cosmos.add_leader_keymapping('n|bd', { ':bw<CR>', name = 'Delete buffer' })

cosmos.add_leader_keymapping('n|ff', { "<cmd>lua require('layers.editor.functions').find_current_directory_files()<CR>", name = 'Find file' })
cosmos.add_leader_keymapping('n|fb', { ":Telescope file_browser<CR>", name = 'File browser' })
cosmos.add_leader_keymapping('n|fr', { '<cmd>Telescope oldfiles<cr>', name = 'Open recent file', noremap = false })

cosmos.add_leader_keymapping('n|fed', { "<cmd>e ~/.cosmos-nvim.lua<CR>", name = 'Open cosmos configuration file' })
cosmos.add_leader_keymapping('n|feD', { "<cmd>lua require('layers.editor.functions').edit_neovim()<CR>", name = 'Open cosmos source files' })
cosmos.add_leader_keymapping('n|feR', { "<cmd>lua require('layers.editor.functions').reload_configuration()<CR>", name = 'Reload configuration' })

cosmos.add_leader_keymapping('n|pp', { '<cmd>Telescope projects theme=' .. options.telescope_theme .. '<cr>', name = 'Switch project' })
cosmos.add_leader_keymapping('n|pf', { '<cmd>Telescope find_files<CR>', name = 'Find project files' })

cosmos.add_leader_keymapping('n|jj', { '<Plug>(easymotion-s)', name = 'Jump to char' })
cosmos.add_leader_keymapping('n|jl', { '<Plug>(easymotion-bd-jk)', name = 'Jump to line' })
cosmos.add_leader_keymapping('n|ji', { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", name = 'Jump to symbol' })

cosmos.add_leader_keymapping('n|se', { ':Lspsaga rename<CR>', name = 'Edit symbol' })
cosmos.add_leader_keymapping('n|ss', { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find { fuzzy = false, case_mode = 'ignore_case' }<cr>", name = 'Search current buffer' })
cosmos.add_leader_keymapping('n|sh', { "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", name = 'Hover symbol' })
cosmos.add_leader_keymapping('n|sp', { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", name = "Preview symbol" })
cosmos.add_leader_keymapping('n|sH', { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", name = 'Show symbol signature' })

cosmos.add_leader_keymapping('n|el', { "<cmd>lua require('telescope.builtin').diagnostics{ bufnr=0 }<cr>", name = 'List errors' })
cosmos.add_leader_keymapping('n|en', { ':Lspsaga diagnostic_jump_next<CR>', name = 'Next error' })
cosmos.add_leader_keymapping('n|ep', { ':Lspsaga diagnostic_jump_prev<CR>', name = 'Previous error' })
cosmos.add_leader_keymapping('n|ef', { ':Lspsaga code_action<CR>', name = 'Fix error' })

cosmos.add_leader_keymapping('v|;;', { 'gcc<Esc>', name = 'Comment line', noremap = false })

cosmos.add_leader_keymapping("n|'", { '<CMD>lua require("FTerm").toggle()<CR>', name = 'Open shell' })
cosmos.add_leader_keymapping('n|*', { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", name = 'Search reference in current project' })
cosmos.add_leader_keymapping('n|/', { ':Telescope live_grep<CR>', name = 'Search project' })
cosmos.add_leader_keymapping('n|<Tab>', { ':b#<CR>', name = 'Last buffer' })
cosmos.add_leader_keymapping('n|<Space>', { "<cmd>lua require('layers.editor.functions').commands(require('telescope.themes').get_" .. options.telescope_theme .. "({}))<CR>", name = 'Commands' })

utils.nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.nmap('gD', ':Lspsaga preview_definition<CR>')
utils.set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", { noremap = true, silent = true })
utils.set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", { noremap = true, silent = true })
utils.tmap('<A-d>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
utils.set_keymap('n', 's', '<Plug>(easymotion-overwin-f)', {})
utils.set_keymap('n', '<leader>;;', 'gcc', {})
utils.set_keymap('v', '<leader>;', 'gcc<esc>', {})

