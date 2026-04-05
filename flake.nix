{
  description = "Global dotfiles — shared across all machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code-overlay = {
      url = "github:ryoppippi/claude-code-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, claude-code-overlay, ... }: {

    darwinModules = {
      default = import ./nix/darwin;
    };

    homeManagerModules = {
      default = { pkgs, ... }: {
        imports = [
          ./nix/home/packages.nix
          ./nix/home/shell.nix
          ./nix/home/git.nix
        ];

        home.file = {
          ".config/nvim" = { source = "${self}/.config/nvim"; recursive = true; };
          ".config/yazi" = { source = "${self}/.config/yazi"; recursive = true; };
          ".config/wezterm" = { source = "${self}/.config/wezterm"; recursive = true; };
          ".config/aerospace" = { source = "${self}/.config/aerospace"; recursive = true; };
          ".aerospace.toml".source = "${self}/.aerospace.toml";
          ".hammerspoon" = { source = "${self}/.hammerspoon"; recursive = true; };
        };

        home.stateVersion = "24.11";
      };
    };

    overlays.claude-code = claude-code-overlay.overlays.default;
  };
}
