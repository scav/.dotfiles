local Plugin = {'saecki/crates.nvim'}

Plugin.name = 'crates'

Plugin.opts = {
    event = {
        "BufRead Cargo.toml"
    },
}

function Plugin.config(name, opts)
    require('crates').setup()
end

return Plugin
