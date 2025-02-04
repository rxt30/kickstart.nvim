return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  keys = {
    { 'gn', ':Neorg workspace notes<CR>', desc = 'Go to notes workspace', silent = true },
    { 'gb', ':Neorg return<CR>', desc = 'Go back from notes workspace', silent = true },
    { 'gl', '<Plug>(neorg.esupports.hop.hop-link)', desc = 'Go to norg link', silent = true },
    { 'ss', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', desc = 'Switch task status', silent = true },
  },
  config = function()
    vim.g.maplocalleader = '-'
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/.neorg',
            },
          },
        },
      },
    }
  end,
}
