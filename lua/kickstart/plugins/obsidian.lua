return {
  'epwalsh/obsidian.nvim',
  lazy = false,
  version = '*',
  keys = {
    { 'gn', ':ObsidianQuickSwitch<CR>', desc = 'Quickswitch obsidian', silent = true },
    { 'gl', ':ObsidianFollowLink<CR>', desc = 'Follow obsidian link', silent = true },
  },
  opts = {
    workspaces = {
      {
        name = 'nodedaemon',
        path = '~/vaults/nodedaemon',
      },
    },
  },
}
