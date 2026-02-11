{ pkgs, ... }:

{
  # todo: clean up
  environment.systemPackages = with pkgs; [
    #mac
    gnumake
    coreutils
    gnutls
    gnupg
    openssh
    docker

    # generic
    awscli2
    azure-cli
    bat
    buf
    crossplane
    dyff
    eza
    fzf
    gh
    git
    grpcurl
    kubernetes-helm
    jq
    k6
    ko
    kind
    kubectl
    kubelogin
    kustomize
    mkcert
    pinentry_mac
    protobuf
    qemu
    sops
    step-cli
    talosctl
    tree
    utm
    watch
    wget
    yq
    zstd
  ];
}
