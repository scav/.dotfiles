{
  ...
}:

{
  programs.glide-browser.profiles.scav.bookmarks = [
    {
      name = "Bookmarks Toolbar";
      toolbar = true;
      bookmarks = [
        {
          name = "home-manager - MyNixOS";
          url = "https://mynixos.com/home-manager";
        }
        {
          name = "Network";
          bookmarks = [
            {
              name = "OPNSense";
              url = "https://fw.devbugger.com";
            }
            {
              name = "pv1";
              url = "https://pv1.devbugger.com:8006";
            }
            {
              name = "unifios";
              url = "https://unifios.devbugger.com:11443";
            }
          ];
        }

        {
          name = "Programming";
          bookmarks = [
            {
              name = "zizmorcore/zizmor: Static analysis for GitHub Actions";
              url = "https://github.com/zizmorcore/zizmor";
            }
            {
              name = "HigherOrderCO/Bend: A massively parallel, high-level programming language";
              url = "https://github.com/HigherOrderCO/Bend";
            }
          ];
        }

        {
          name = "Misc";
          bookmarks = [
            {
              name = "Crucial M4 2.5-inch SSD firmware updates | crucial.com";
              url = "https://www.crucial.com/support/ssd-support/m4-25-inch-support";
            }
          ];
        }

        {
          name = "Entertainment";
          bookmarks = [
            {
              name = "Home - Netflix";
              url = "https://www.netflix.com";
            }
            {
              name = "Watchlist | Disney+";
              url = "https://www.disneyplus.com";
            }
            {
              name = "Forsiden | TV 2 Play";
              url = "https://play.tv2.no/";
            }
            {
              name = "Apple TV";
              url = "https://tv.apple.com/";
            }

            {
              name = "nzb";
              bookmarks = [
                {
                  name = "Nzbgeek";
                  url = "https://nzbgeek.info";
                }
                {
                  name = "Eweka";
                  url = "https://www.eweka.nl/en";
                }
                {
                  name = "NZBGet";
                  url = "http://localhost:6789/#";
                }
              ];
            }

            {
              name = "Jellyfin - onyx";
              url = "http://localhost:8096/web/#/home";
            }
          ];
        }

        {
          name = "Tech";
          bookmarks = [
            {
              name = "nspawn - Debian Wiki";
              url = "https://wiki.debian.org/nspawn";
            }
            {
              name = "Installation | kubecolor";
              url = "https://kubecolor.github.io/setup/install/";
            }
            {
              name = "Home | D2 Documentation";
              url = "https://d2lang.com/";
            }
          ];
        }

        {
          name = "Nix";
          bookmarks = [
            {
              name = "MyNixOS";
              url = "https://mynixos.com/";
            }
          ];
        }
      ];
    }
  ];
}
