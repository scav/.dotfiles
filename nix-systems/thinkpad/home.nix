{ config, pkgs, ... }:
{
  imports = [
    ../common-linux
    ./modules/hypr
    ./modules/waybar.nix
  ];

  home.username = "scav";
  home.homeDirectory = "/home/scav";
  home.stateVersion = "26.05";
  programs.zsh = {
    enable = true;
    shellAliases = {
      nrt = "nix flake update; sudo nixos-rebuild test --flake ${config.home.homeDirectory}/.dotfiles#thinkpad";
      nru = "nix flake update; sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles#thinkpad";
      nrs = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles#thinkpad";
      # Yep...
      pbcopy = "wl-copy ";
      pbpaste = "wl-paste ";
    };
  };

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplicationPackages = [
        config.programs.glide-browser.package
      ];
    };
  };

  home.packages = with pkgs; [
    playerctl
    wl-clipboard
    scavpkgs.wxctl

    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    kubectl
    azure-cli
    awscli2
    amazon-ecr-credential-helper
    kubectl
    kubelogin

    kustomize
    crossplane
    kubernetes-helm
    k6

    gh
    dyff
    grpcurl
    step-cli
    tree
    yq
  ];

}
