{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      lg = "lazygit";
      ld = "lazydocker";
      yz = "yazi";
      cl = "claude";
    };

    initContent = ''
      [ -f ~/.secrets ] && source ~/.secrets
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}
