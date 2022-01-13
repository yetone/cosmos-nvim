local utils = require('utils')

utils.safe_require('which-key', function(wk)
  wk.register({
    w = {
      name = '+Windows',
      s = { '<C-w>s', 'Split window below' },
      v = { '<C-w>v', 'Split window right' },
      ['-'] = { '<C-w>s', 'Split window below' },
      ['/'] = { '<C-w>v', 'Split window right' },
      w = { '<C-w>w', 'Other window' },
      j = { '<C-w>j', 'Go to the down window' },
      k = { '<C-w>k', 'Go to the up window' },
      h = { '<C-w>h', 'Go to the left window' },
      l = { '<C-w>l', 'Go to the right window' },
      d = { '<C-w>c', 'Delete window' },
      m = { '<C-w>o', 'Maximize window' },
    },
    b = {
      name = '+Buffers',
      b = { "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<cr>", 'List buffers' },
      n = { ':BufferLineCycleNext<CR>', 'Next buffer' },
      p = { ':BufferLineCyclePrev<CR>', 'Previous buffer' },
      d = { ':bw<CR>', 'Delete buffer' },
    },
    f = {
      name = '+Files',
      f = { "<cmd>lua require'functions'.find_current_directory_files()<CR>", 'Find file' },
      b = { ":Telescope file_browser<CR>", 'File browser' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Open recent file', noremap = false },
      e = {
        name = 'Config files',
        d = { "<cmd>lua require'functions'.edit_neovim()<CR>", 'Open dotfiles' },
        R = { "<cmd>lua require'functions'.reload_configuration()<CR>", 'Reload configuration' },
      }
    },
    p = {
      name = '+Projects',
      p = { '<cmd>Telescope projects theme=ivy<cr>', 'Switch project' },
      f = { '<cmd>Telescope find_files<CR>', 'Find project files' },
    },
    j = {
      name = '+Jump',
      j = { '<Plug>(easymotion-s)', 'Jump to char' },
      l = { '<Plug>(easymotion-bd-jk)', 'Jump to line' },
      i = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", 'Jump to symbol' },
    },
    s = {
      name = '+Search/Symbols',
      e = { ':Lspsaga rename<CR>', 'Edit symbol' },
      s = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find { fuzzy = false,  case_mode = 'ignore_case' }<cr>", 'Search current buffer' },
      h = { "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", 'Hover symbol' },
      p = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", "Preview symbol" },
      H = { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", 'Show symbol signature' },
    },
    g = {
      name = '+Git',
      s = { ':Magit<CR>', 'Magit status' },
    },
    e = {
      name = '+Errors',
      l = { "<cmd>lua require('telescope.builtin').diagnostics{ bufnr=0 }<cr>", 'List errors' },
      n = { ':Lspsaga diagnostic_jump_next<CR>', 'Next error' },
      p = { ':Lspsaga diagnostic_jump_prev<CR>', 'Previous error' },
      f = { ':Lspsaga code_action<CR>', 'Fix error' },
    },
    [';'] = {
      name = 'Comment',
      [';'] = {
        'gcc<Esc>', 'Comment line', noremap = false, mode = 'v',
      },
    },
    ["'"] = { '<CMD>lua require("FTerm").toggle()<CR>', 'Open shell' },
    ['*'] = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", 'Search reference in current project' },
    ['/'] = { ':Telescope live_grep<CR>', 'Search project' },
    ['<Tab>'] = { ':b#<CR>', 'Last buffer' },
    ['<Space>'] = { "<cmd>lua require('functions').commands(require('telescope.themes').get_ivy({}))<CR>", 'Commands' },
  }, { prefix = '<leader>' })
  require('utils').setup_user_mappings(wk)
end)
