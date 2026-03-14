{ pkgs, ... }:

let
  wallpapers = pkgs.fetchFromGitHub {
    owner = "mylinuxforwork";
    repo = "wallpaper";
    rev = "main";
    sha256 = "sha256-a3GwidRDy8Ke2V5EHwHEZr1smSgNG3N70faZ2lCrmnw=";
  };

  # tokyonight-ish colours
  font_type = "JetBrainsMono NF";
  font_color = "rgb(a9b1d6)";
  border_color = "rgb(7aa2f7)";
  label_font_color = "rgb(9ece6a)";
  label_font_color_2 = "rgb(ff9e64)";
  layout_font_color = "rgb(ff9e64)";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = [
        {
          monitor = "";
          color = "rgb(24283b)";
          path = "${wallpapers}/astronaut_jellyfish.jpg";
        }
      ];

      "input-field" = [
        {
          monitor = "";
          size = "20%, 5%";
          outline_thickness = 3;
          inner_color = "rgba(0, 0, 0, 0.0)";
          outer_color = border_color;
          check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
          fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";
          font_color = font_color;
          fade_on_empty = false;
          rounding = 15;
          font_family = font_type;
          placeholder_text = "";
          fail_text = "$PAMFAIL";
          dots_spacing = 0.3;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # LOCK SYMBOL
        {
          monitor = "";
          text = "<span>  </span>";
          font_size = 24;
          color = layout_font_color;
          position = "-400, -20";
          halign = "center";
          valign = "center";
        }
        # LAYOUT
        {
          monitor = "";
          text = "$LAYOUT[  🇺🇸 ,  🇳🇴]";
          font_size = 24;
          color = layout_font_color;
          onclick = "hyprctl switchxkblayout current next && pkill -RTMIN+8 waybar";
          position = "400, -20";
          halign = "center";
          valign = "center";
        }
        # TIME
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          font_family = font_type;
          color = label_font_color;
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
        # DATE
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          font_size = 25;
          font_family = font_type;
          color = label_font_color_2;
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = "Hello,  $DESC";
          font_size = 25;
          font_family = font_type;
          color = label_font_color;
          position = "0, 200";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
