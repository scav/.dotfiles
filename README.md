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

## Clean up

If messing up with substituters clean up likes so:
```bash
```bash
sudo nixos-rebuild switch \
  --flake /home/scav/.dotfiles#thinkpad \
  --option substituters 'https://cache.nixos.org/ https://cache.nixos-cuda.org https://scavpkgs.cachix.org'
```

