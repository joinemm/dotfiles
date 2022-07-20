require('colorizer').setup()
require('guess-indent').setup {}
require('gitsigns').setup()
require('Comment').setup()
require('lualine').setup {
  options = {
    theme = 'nord',
    section_separators = '',
    component_separators = '|',
  }
}
require("which-key").setup {}

vim.cmd[[highlight IndentBlanklineContextChar guifg=#ebcb8b gui=nocombine]]
require("indent_blankline").setup {
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter_scope = true,
}
