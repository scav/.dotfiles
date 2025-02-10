local Plugin = { 'mfussenegger/nvim-dap' }
Plugin.dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',

    -- Go
    'leoluz/nvim-dap-go',
}

function Plugin.config()
    local dap = require('dap')
    local dapui = require('dapui')
    local dapgo = require('dap-go')

    require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
            'cpptools',
            'codelldb',
            'delve',
        },
    }
    -- Basic debugging keymaps, feel free to change to your liking
    vim.keymap.set('n', '<leader>bb', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>bc', dapgo.debug_test, { desc = 'Debug: Closest Test' })
    vim.keymap.set('n', '<leader>1', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>2', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>3', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

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
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>7', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
        dap_configurations = {
            {
                type = "go",
                name = "Attach remote",
                mode = "remote",
                request = "attach",
            },
        },
    }

    -- Rust specific
    dap.adapters.codelldb = {
        type = 'executable',
        command = '/Users/dag/.local/share/nvim/mason/bin/codelldb',
    }
end

return Plugin
