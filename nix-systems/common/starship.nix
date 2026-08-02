{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$all$directory$character";

      directory.truncation_length = 2;

      direnv = {
        disabled = false;
        style = "green";
        format = "[$symbol$loaded/$allowed]($style)";
      };

      golang.format = "[$symbol$version](cyan bold) ";

      hostname = {
        ssh_only = false;
        format = "[$hostname](bold red) ";
      };

      kubernetes = {
        disabled = false;
        format = " [󱃾 $context](dimmed blue) "; # Kept: custom symbol not in default preset
      };

      rust.format = "[$symbol$version](red bold) ";

      # Disabled modules
      azure.disabled = true;
      docker_context.disabled = true;
      fossil_branch.disabled = true;
      gcloud.disabled = true;
      nodejs.disabled = true;
      deno.disabled = true;
    };
  };
}
