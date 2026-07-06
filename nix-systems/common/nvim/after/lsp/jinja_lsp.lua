---@type vim.lsp.Config
return {
    name = "jinja_lsp",
    cmd = { "jinja-lsp", "--stdio" },
    filetypes = { "jinja", "html", "rust" },
    root_markers = { ".git" },
}
