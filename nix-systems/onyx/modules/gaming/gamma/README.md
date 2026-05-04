# Installing Stalker w/ G.A.M.M.A
Based on [this](https://gist.github.com/v1ld/e9069af307bd90495e0b345f3a260725) guide for Linux.

This will create a script wrapping `gamma-launcher` called `gamma-installer`. This will take a very
long time so I have not bothered adding a full nix-module for the entire step.


## Post install
1. Add MO2 as external game to Steam
2. Run protontrics
    ```sh
    protontricks 3519132989 cmd d3dcompiler_47 d3dx10 d3dx11_43 d3dx9 dx8vb quartz vcrun2022
    ```
