# dotfiles

Nix based setup for my MacBooks and NixOS machines

## Setup new machines

MacOS: 
```bash
sudo nix run github:nix-darwin/nix-darwin -- switch --flake .#wrk
```

