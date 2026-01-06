local load = function(mod)
    package.loaded[mod] = nil
    require(mod)
end

load("user.settings")
load("user.keymaps")
require("user.plugins")

pcall(vim.cmd.colorscheme, "tokyonight-storm")

-- Add more colours to the line numbers
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FB508F", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#51B3EC", bold = true })
