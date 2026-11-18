-- Some "tuning" of neovim
local opt = vim.opt

-- maxmempattern set to 2000000 is basically unlimited
-- avoids syntax highlight failing on big or complex files
opt.maxmempattern = 2000000
