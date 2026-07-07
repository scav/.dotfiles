---@type vim.lsp.Config
return {
    name = "jinja_lsp",
    cmd = { "jinja-lsp", "--stdio" },
    filetypes = { "jinja", "html", "rust", "htmldjango" },
    root_markers = { ".git" },
}
