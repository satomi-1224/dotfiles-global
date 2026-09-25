{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools
    bun
    ripgrep
    lazygit
    fzf
    gh
    glow
    ouch
    ffmpegthumbnailer
    mpv
    tree-sitter
    nodejs
    nb
    ghq
    herdr
    # Docker
    docker-client
    docker-compose
    lazydocker
  ];

  # Ghostty is only the outer terminal. Herdr owns every multiplexing feature:
  # workspaces, tabs, panes, navigation, resizing, and scrollback.
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    clearDefaultKeybinds = true;
    settings = {
      command = lib.getExe pkgs.herdr;
      shell-integration = "none";
      scrollback-limit = 0;
      window-save-state = "never";
      window-decoration = "none";
      macos-applescript = false;
      command-palette-entry = "";

      # Terminal appearance.
      theme = "Selenized Dark";
      background-opacity = 0.8;
      background-blur = 20;
      font-family = [
        "JetBrainsMono Nerd Font"
        "Hiragino Sans"
        "Menlo"
        "Monaco"
      ];
      font-feature = "-calt,-clig,-liga,-dlig";
      font-size = 14;
      window-padding-x = 8;
      window-padding-y = 6;
      macos-option-as-alt = "left";

      # Restore only terminal-emulator operations that do not overlap with Herdr.
      keybind = [
        "performable:super+c=copy_to_clipboard"
        "super+v=paste_from_clipboard"
        "super+equal=increase_font_size:1"
        "super+minus=decrease_font_size:1"
        "super+zero=reset_font_size"
        "super+shift+comma=reload_config"

        # Shell input conveniences.
        "shift+enter=text:\\n"
        "super+g=text:\\x1b[71;9u"
      ];
    };
  };

  # Neovim
  # home-manager は programs.neovim.enable = true のとき init.lua を自動生成して
  # provider 設定だけを書き出す。そのままだと .config/nvim/init.lua が読み込まれ
  # ないため、initLua でユーザー設定の require を追加する。
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    initLua = ''
      require("config.options")
      require("config.keymaps")
      require("config.autocmds")
      require("config.lazy")
    '';
  };

  # Yazi (file manager)
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };
}
