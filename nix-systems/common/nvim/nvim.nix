{ pkgs, ... }:
let

in
{
  # All other LPS are added with nix on a project to project basis
  home.packages = with pkgs; [
    tree-sitter
    deadnix
    lua-language-server
    yaml-language-server
    nil
    stylua
    statix
    oxfmt
  ];

  programs.zsh = {
    shellAliases = {
      nvimDev = "(cd ~/.dotfiles; nix run .#darwinConfigurations.wrk.config.home-manager.users.dag.programs.mnw.finalPackage.devMode)";
    };
  };

  programs.mnw = {
    enable = true;
    aliases = [ "vim" ];
    luaFiles = [
      ./init.lua
    ];
    plugins = with pkgs; {
      dev.config = {
        pure = ./.;
        impure = "/Users/dag/.dotfiles/nix-systems/common/nvim";
      };
      # Eager plugins
      start = [
        vimPlugins.lz-n
        vimPlugins.plenary-nvim
        vimPlugins.tokyonight-nvim
        vimPlugins.telescope-nvim
        vimPlugins.telescope-fzf-native-nvim
        vimPlugins.telescope-ui-select-nvim
        vimPlugins.telescope-undo-nvim
        vimPlugins.oil-nvim
        vimPlugins.blink-cmp
        vimPlugins.blink-nerdfont-nvim
        vimPlugins.friendly-snippets
        vimPlugins.lspkind-nvim
        vimPlugins.lazydev-nvim
        vimPlugins.none-ls-nvim
        vimPlugins.vim-fugitive
        vimPlugins.gitsigns-nvim
        vimPlugins.conform-nvim
        vimPlugins.kulala-nvim
        vimPlugins.vim-dadbod
        vimPlugins.vim-dadbod-completion
        vimPlugins.vim-dadbod-ui
        vimPlugins.nvim-web-devicons
        vimPlugins.nvim-lspconfig
        vimPlugins.lualine-nvim
        vimPlugins.which-key-nvim
        vimPlugins.indent-blankline-nvim
        vimPlugins.nvim-autopairs
        vimPlugins.crates-nvim
        vimPlugins.trouble-nvim

        vimPlugins.neotest
        vimPlugins.nvim-nio
        vimPlugins.FixCursorHold-nvim
        vimPlugins.neotest-golang
        vimPlugins.neotest-rust

        vimPlugins.nvim-treesitter
        vimPlugins.nvim-treesitter-textobjects
        vimPlugins.nvim-treesitter-context
        (vimPlugins.nvim-treesitter.withPlugins (p: [
          p.gitignore
          p.nix
          p.rust
          p.go
          p.yaml
          p.toml
          p.dockerfile
          p.json
          p.sql
          p.templ
          p.html
          p.css
        ]))
        vimPlugins.rainbow-delimiters-nvim
      ];
      # Lazy plugins
      opt = [
      ];
    };
  };
}
