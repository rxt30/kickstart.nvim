-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { 'dc', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
      { 'db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { 'dt', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dap.adapters.firefox = {
      type = 'executable',
      command = vim.fn.exepath 'firefox-debug-adapter',
      -- args = { os.getenv 'HOME' .. '/path/to/vscode-firefox-debug/dist/adapter.bundle.js' },
    }
    dap.adapters.chrome = {
      type = 'executable',
      command = vim.fn.exepath 'chrome-debug-adapter',
    }

    dap.configurations.typescriptreact = {
      -- {
      --   name = 'Debug with Firefox',
      --   type = 'firefox',
      --   request = 'launch',
      --   reAttach = true,
      --   url = 'http://localhost:3005',
      --   webRoot = '${workspaceFolder}',
      --   firefoxExecutable = '/usr/bin/firefox-aurora',
      --   profile = 'debug',
      -- },
      {
        name = 'Debug with Chrome',
        type = 'chrome',
        request = 'attach',
        reAttach = true,
        webRoot = '${workspaceFolder}',
        runtimeExecutable = '/usr/bin/chromium-browser',
        port = 9222,
        sourceMaps = true,
        protocol = 'inspector',
        urlFilter = 'http://localhost:3005*',
      },
    }

    dap.configurations.typescript = {
      -- {
      --   name = 'Debug with Firefox',
      --   type = 'firefox',
      --   request = 'launch',
      --   reAttach = true,
      --   url = 'http://localhost:3005',
      --   webRoot = '${workspaceFolder}',
      --   firefoxExecutable = '/usr/bin/firefox-aurora',
      --   profile = 'debug',
      -- },
      {
        name = 'Debug with Chrome',
        type = 'chrome',
        request = 'attach',
        reAttach = true,
        webRoot = '${workspaceFolder}',
        runtimeExecutable = '/usr/bin/chromium-browser',
        port = 9222,
        sourceMaps = true,
        protocol = 'inspector',
        urlFilter = 'http://localhost:3005*',
      },
    }
    -- require('mason-nvim-dap').setup {
    --   -- Makes a best effort to setup the various debuggers with
    --   -- reasonable debug configurations
    --   automatic_installation = true,
    --
    --   -- You can provide additional configuration to the handlers,
    --   -- see mason-nvim-dap README for more information
    --   handlers = {
    --     function(config)
    --       require('mason-nvim-dap').default_setup(config)
    --     end,
    --     firefox = function(config)
    --       config.configurations = { typescriptreact = {
    --         url = 'http://localhost:3005',
    --       } }
    --       require('mason-nvim-dap').default_setup(config)
    --     end,
    --   },
    --
    --   -- You'll need to check that you have the required things installed
    --   -- online, please don't ask me how to install them :)
    --   ensure_installed = {
    --     -- Update this to ensure that you have the debuggers for the langs you want
    --     'delve',
    --   },
    -- }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.5,
            },
            {
              id = 'breakpoints',
              size = 0.5,
            },
          },
          position = 'left',
          size = 65,
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
  end,
}
