{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools
    ripgrep
    lazygit
    fzf
    gh
    glow
    ouch
    ffmpegthumbnailer
    mpv
    claude-code
    tree-sitter
    nodejs
    # Docker
    docker-client
    docker-compose
    lazydocker
    # Fonts
    nerd-fonts.jetbrains-mono
  ];

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
