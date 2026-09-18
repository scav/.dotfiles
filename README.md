# dotfiles

Nix based setup for my MacBooks and NixOS machines

## Setup new machines

MacOS: 
```bash
sudo nix run github:nix-darwin/nix-darwin -- switch --flake .#wrk
```

## Notes
Extracting resident keys, just run this and put the key in `~/.ssh` and the `git.nix` config
in this repos will do the rest.
```bash
ssh-keygen -K
```
