# dotfiles-global

macOS 共通設定を管理する Nix Flake リポジトリ。
マシン固有の dotfiles リポジトリから Flake input として参照して使う。

## 構成

```
flake.nix              darwinModules, homeManagerModules, overlays を出力
nix/
  darwin/              macOS system defaults, 共通 homebrew casks
  home/                packages, shell, git (共通部分)
.config/               nvim, wezterm, yazi
magicboard/            MagicBoard アプリ
scripts/               セットアップスクリプト
```

ウィンドウ管理とランチャーは自作アプリへ置き換えたため、ここには設定を置かない。
どちらも**アクセシビリティ権限がアプリの同一性に紐づく**関係で本体を Nix store に
置けないので、設定と自動起動だけを各アプリの home-manager モジュールが受け持つ。

| 置き換え前 | 置き換え後 |
|---|---|
| AeroSpace（`.aerospace.toml`） | [comet](https://github.com/satomi-1224/comet) |
| Hammerspoon（`.hammerspoon/`） | [compass](https://github.com/satomi-1224/compass) |

## Flake outputs

| Output | 内容 |
|--------|------|
| `darwinModules.default` | macOS system defaults, Touch ID, Finder, Dock, 共通 homebrew casks |
| `homeManagerModules.default` | packages, shell, git(共通部分), dotfile symlinks |

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
