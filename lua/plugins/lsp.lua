return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        },
        config = function()
            local lsp = require('lsp-zero').preset({
                name = 'recommended',
                    set_lsp_keymaps = true,
                    manage_nvim_cmp = true,
                    suggest_lsp_servers = true,
                })

                lsp.ensure_installed({
                    'tsserver',
                    'rust_analyzer',
                })

                lsp.set_preferences({
                    suggest_lsp_servers = true
                })

                lsp.nvim_workspace()
                lsp.setup()

                vim.diagnostic.config({
                    virtual_text = true,
                })

                local cmp = require('cmp')
                local cmp_action = require('lsp-zero').cmp_action()

                cmp.setup({
                    preselect = 'item',
                    completion = {
                        completeopt = 'menu,menuone,noinsert'
                    },
                    mapping = {
                        ['<CR>'] = cmp.mapping.confirm({select = false}),
                        ['<Tab>'] = cmp.mapping.confirm({select = false}),
                        ['C-Space'] = cmp.mapping.complete(),

                        -- ['<Tab>'] = cmp_action.tab_complete(),
                        -- ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                    }
                })
        end
    }
}
