{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools
    ripgrep
    lazygit
    glow
    ouch
    ffmpegthumbnailer
    mpv
    claude-code
    tree-sitter
    # Docker
    docker-client
    docker-compose
    lazydocker
    # Fonts
    nerd-fonts.jetbrains-mono
  ];

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Yazi (file manager)
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };
}
