{ config, pkgs, ... }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
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
      nvimDev = (
        if isDarwin then
          "(cd ${config.home.homeDirectory}/.dotfiles; nix run .#darwinConfigurations.wrk.config.home-manager.users.${config.home.username}.programs.mnw.finalPackage.devMode)"
        else
          "(cd ${config.home.homeDirectory}/.dotfiles; nix run .#nixosConfigurations.onyx.config.home-manager.users.${config.home.username}.programs.mnw.finalPackage.devMode)"
      );
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
        impure = "${config.home.homeDirectory}/.dotfiles/nix-systems/common/nvim";
      };
      # Eager plugins
      start = with vimPlugins; [
        lz-n
        plenary-nvim
        tokyonight-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        telescope-undo-nvim
        oil-nvim
        blink-cmp
        blink-nerdfont-nvim
        friendly-snippets
        lspkind-nvim
        lazydev-nvim
        none-ls-nvim
        vim-fugitive
        gitsigns-nvim
        conform-nvim
        kulala-nvim
        nvim-web-devicons
        nvim-lspconfig
        lualine-nvim
        which-key-nvim
        indent-blankline-nvim
        nvim-autopairs
        crates-nvim
        trouble-nvim
        markview-nvim

        # Database
        vim-dadbod
        vim-dadbod-completion
        vim-dadbod-ui

        # Debug
        nvim-dap
        nvim-dap-view
        nvim-dap-go
        nvim-dap-lldb

        # Testing
        neotest
        nvim-nio
        FixCursorHold-nvim
        neotest-golang
        neotest-rust

        # tree-sitter / highlight
        nvim-treesitter
        nvim-treesitter-textobjects
        nvim-treesitter-context
        (nvim-treesitter.withPlugins (p: [
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
          p.http
          p.javascript
          p.zig
        ]))
        rainbow-delimiters-nvim
      ];
      # Lazy plugins
      opt = [
      ];
    };
  };
}
