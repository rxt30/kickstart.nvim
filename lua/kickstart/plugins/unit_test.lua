return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-jest' {
          jestCommand = 'yarn test --',
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
    }
  end,
  keys = {
    {
      'tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run tests for file',
      silent = true,
    },
    {
      'tw',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle test window',
      silent = true,
    },
  },
}
