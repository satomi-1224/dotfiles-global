# dotfiles-global

macOS 共通設定を管理する Nix Flake リポジトリ。
マシン固有の dotfiles リポジトリから Flake input として参照して使う。

## 構成

```
flake.nix              darwinModules, homeManagerModules, overlays を出力
nix/
  darwin/              macOS system defaults, 共通 homebrew casks
  home/                packages, shell, git (共通部分)
.config/               nvim, wezterm, yazi, aerospace
.hammerspoon/          Hammerspoon 設定
.aerospace.toml        AeroSpace 設定
magicboard/            MagicBoard アプリ
scripts/               セットアップスクリプト
```

## Flake outputs

| Output | 内容 |
|--------|------|
| `darwinModules.default` | macOS system defaults, Touch ID, Finder, Dock, 共通 homebrew casks |
| `homeManagerModules.default` | packages, shell, git(共通部分), dotfile symlinks |
| `overlays.claude-code` | claude-code overlay の再エクスポート |

## 使い方

固有リポジトリの `flake.nix` で input に追加:

```nix
inputs.dotfiles-global = {
  url = "github:your-user/dotfiles-global";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.follows = "home-manager";
};
```

## カスタマイズ

- **パッケージ追加**: 固有リポジトリで `home.packages` に追記 (リストは自動マージ)
- **homebrew cask 追加**: 固有リポジトリで `homebrew.casks` に追記
- **値の上書き**: `lib.mkForce` を使用
