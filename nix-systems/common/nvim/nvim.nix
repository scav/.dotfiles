{ pkgs, ... }:
let

in
{
  # All other LPS are added with nix on a project to project basis
  home.packages = with pkgs; [
    lua-language-server
    nil
  ];

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
        vimPlugins.lazy-nvim
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
        vimPlugins.vim-fugitive

        vimPlugins.nvim-treesitter
        vimPlugins.nvim-treesitter-textobjects
        vimPlugins.nvim-treesitter-context
        (vimPlugins.nvim-treesitter.withPlugins (p: [
          p.nix
          p.rust
          p.go
          p.yaml
          p.toml
        ]))
      ];
      # Lazy plugins
      opt = [
        vimPlugins.nvim-web-devicons
        vimPlugins.nvim-lspconfig
        vimPlugins.lualine-nvim
        vimPlugins.which-key-nvim
        vimPlugins.indent-blankline-nvim
        vimPlugins.nvim-autopairs
        vimPlugins.crates-nvim
      ];
    };
  };
}
