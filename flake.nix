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
          ".config/nvim".source = "${self}/.config/nvim";
          ".config/yazi".source = "${self}/.config/yazi";
          ".config/wezterm".source = "${self}/.config/wezterm";
          ".config/aerospace".source = "${self}/.config/aerospace";
          ".aerospace.toml".source = "${self}/.aerospace.toml";
          ".hammerspoon".source = "${self}/.hammerspoon";
        };

        home.stateVersion = "24.11";
      };
    };

    overlays.claude-code = claude-code-overlay.overlays.default;
  };
}
