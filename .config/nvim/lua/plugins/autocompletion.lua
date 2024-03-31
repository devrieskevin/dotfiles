return {
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                sources = cmp.config.sources(
                    {
                        { name = 'copilot' },
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                    },
                    {
                        { name = 'buffer' }
                    }
                ),
            })
        end
    }
}
