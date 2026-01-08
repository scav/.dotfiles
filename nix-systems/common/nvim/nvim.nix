{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # LSP
  home.packages = with pkgs; [
    # rust-analyzer
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
        # impure = "/home/scav/nixos/nvim";
      };
      # Eager plugins
      start = [
        vimPlugins.lazy-nvim
        vimPlugins.plenary-nvim
        vimPlugins.tokyonight-nvim
        vimPlugins.oil-nvim
        vimPlugins.nvim-treesitter
        # vimPlugins.nvim-treesitter-textobjects
        vimPlugins.nvim-treesitter-context
        vimPlugins.nvim-treesitter-parsers.nix
        vimPlugins.blink-cmp
        vimPlugins.blink-nerdfont-nvim
        vimPlugins.friendly-snippets
        vimPlugins.vim-fugitive
      ];
      # Lazy plugins
      opt = [
        vimPlugins.nvim-web-devicons
        vimPlugins.telescope-nvim
        vimPlugins.telescope-fzf-native-nvim
        vimPlugins.telescope-ui-select-nvim
        vimPlugins.telescope-undo-nvim
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
