return {
    'numToStr/Comment.nvim',
    version = '^0.8',
    lazy = false,
    config = function()
        require('Comment').setup()
    end,
}
