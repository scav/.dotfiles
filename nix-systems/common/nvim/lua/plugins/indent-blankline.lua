return {
    "indent-blankline.nvim",
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        enabled = true,
        scope = {
            enabled = false,
        },
        indent = {
            char = '▏',
        },
    }
}
