{
  config,
  pkgs,
  inputs,
  ...
}: {
  # LSP
  home.packages = with pkgs; [
    # rust-analyzer
    lua-language-server
    nil
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        keymaps = [
          {
            key = "<leader>K";
            action = ''
              vim.lsp.buf.hover()
            '';
            desc = "LSP: Hover";
            mode = "n";
          }
        ];
        theme = {
          enable = true;
          name = "tokyonight";
          style = "storm";
        };
        lsp = {
          enable = true;
          formatOnSave = true;
        };
        telescope = {
          enable = true;
          extensions = [
            {
              name = "fzf";
              packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }
          ];
        };
        binds = {
          whichKey = {
            enable = true;
          };
        };
        utility = {
          oil-nvim = {
            enable = true;
            setupOpts = {
            };
          };
        };
        languages = {
          lua = {
            enable = true;
            format.enable = true;
            treesitter.enable = true;
            lsp = {
              enable = true;
              lazydev.enable = true;
            };
          };
          nix = {
            enable = true;
            format.enable = true;
            treesitter.enable = true;
          };
          rust = {
            enable = true;
            treesitter.enable = true;
            lsp = {
              enable = true;
              opts = ''
                ['rust-analyzer'] = {
                  cargo = {allFeature = true},
                  checkOnSave = true,
                  procMacro = {
                    enable = true,
                  },
                },
              '';
            };
            extensions = {
              crates-nvim = {
                enable = true;
                setupOpts.completion.crates.enabled = true;
              };
            };
          };
        };
      };
    };
  };
}
