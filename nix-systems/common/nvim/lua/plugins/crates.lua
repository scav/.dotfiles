return {
    'crates.nvim',
        event = { "BufRead Cargo.toml" },
    after = function()
        require('crates').setup()
    end
}
