{
  config,
  pkgs,
  ...
}:

{
  programs.firefox.profiles.default.bookmarks = {
    settings = [
      {
        name = "Mozilla Firefox";
        bookmarks = [
          {
            name = "Get Help";
            url = "https://support.mozilla.org/products/firefox";
          }
          {
            name = "Customize Firefox";
            url = "https://support.mozilla.org/kb/customize-firefox-controls-buttons-and-toolbars?utm_source=firefox-browser&utm_medium=default-bookmarks&utm_campaign=customize";
          }
          {
            name = "Get Involved";
            url = "https://www.mozilla.org/contribute/?utm_medium=firefox-desktop&utm_source=bookmarks-toolbar&utm_campaign=new-users-beta&utm_content=-global";
          }
          {
            name = "About Us";
            url = "https://www.mozilla.org/about/";
          }
        ];
      }

      {
        name = "Bookmarks Toolbar";
        toolbar = true;
        bookmarks = [
          {
            name = "home-manager - MyNixOS";
            url = "https://mynixos.com/home-manager";
          }

          {
            name = "Knowledge";
            bookmarks = [
              {
                name = "(39) What happens to your brain during a migraine - Marianne Schwarz - YouTube";
                url = "https://www.youtube.com/watch?v=qwZypa0iKq8";
              }
              {
                name = "(38) How Did Ancient Humans Get Drunk?(Discovery Of Alcohol) - YouTube";
                url = "https://www.youtube.com/watch?v=YqQPSAq_t_c";
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
                url = "https://www.netflix.com/browse";
              }
              {
                name = "Watchlist | Disney+";
                url = "https://www.disneyplus.com/en-gb/browse/watchlist";
              }
              {
                name = "Forsiden | TV 2 Play";
                url = "https://play.tv2.no/";
              }
              {
                name = "‎Movies on Apple TV - Apple TV (NO)";
                url = "https://tv.apple.com/no/room/movies-on-appletv/edt.item.6454f7d8-98d5-4c09-95a6-b4606de32cc2";
              }
              {
                name = "‎Apple TV";
                url = "https://tv.apple.com/";
              }
              {
                name = "‎Luke Combs - Apple Music";
                url = "https://music.apple.com/no/artist/luke-combs/815635315";
              }

              {
                name = "nzb";
                bookmarks = [
                  {
                    name = "Geek - Dashboard";
                    url = "https://nzbgeek.info/dashboard.php";
                  }
                  {
                    name = "Eweka | Eweka Internet Services | Usenet, Privacy, Security, and More!";
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

              {
                name = "Amazon.com: ASUS ProArt PZ13 AI Powered 2-in-1 Laptop 13.3\" Touch AMOLED 2.8K Display | Qualcomm Snapdragon X Plus X1P-42-100, 16GB M.2 PCIe SSD, Backlit KB, WiFi 7, Webcam, Win 11 Home : Electronics";
                url = "https://www.amazon.com/Touchscreen-Qualcomm-Snapdragon-X1P-42-100-Bluetooth/dp/B0DQLVWH8K?th=1";
              }
            ];
          }

          {
            name = "New tech";
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
                name = "(70) Nix explained from the ground up - YouTube";
                url = "https://www.youtube.com/watch?v=5D3nUU1OVx8";
              }
              {
                name = "(70) Nix is Simpler Than You Think | Derivations & Packages - YouTube";
                url = "https://www.youtube.com/watch?v=GBTTVrmqkfE";
              }
              {
                name = "MyNixOS";
                url = "https://mynixos.com/";
              }
            ];
          }
        ];
      }
    ];
  };
}
