{
  description = "Global dotfiles — shared across all machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {

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
          # AeroSpace は comet へ置き換えた。壁紙の切替も comet が内蔵しているため
          # wallpaper.sh は不要になった（comet の [wallpaper] dir を使う）。
          #
          # **Hammerspoon は compass へ置き換えた**（自作のアプリランチャー）。
          # ランチャー・検索窓・クリップボード履歴・スニペットを compass が受け持つ。
          # 設定と自動起動は compass 側の home-manager モジュールに任せるため、
          # ここには何も置かない。各マシンのローカル設定で有効にする。
        };

        home.stateVersion = "24.11";
      };
    };
  };
}
