return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
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

            lsp.format_on_save({
                format_opts = {
                    async = true,
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['rust_analyzer'] = { 'rust' },
                    ['tsserver'] = { 'javascript', 'typescript', 'jsx', 'tsx', 'js', 'ts' },
                    ['gopls'] = { 'go' },
                    -- c++
                    ['clangd'] = { 'c', 'cpp' },
                    -- if you have a working setup with null-ls
                    -- you can specify filetypes it can format.
                    -- ['null-ls'] = {'javas
                    -- cript', 'typescript'},
                }
            })

            lsp.on_attach()

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
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<Tab>'] = cmp.mapping.confirm({ select = false }),
                    ['C-Space'] = cmp.mapping.complete(),

                    -- ['<Tab>'] = cmp_action.tab_complete(),
                    -- ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                }
            })
        end
    }
}
