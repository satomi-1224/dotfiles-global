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

      function ghq-fzf-widget() {
        local dir
        dir=$(ghq list --full-path | fzf) || return
        [ -n "$dir" ] || return
        BUFFER="cd ''${(q)dir}"
        zle accept-line
      }
      zle -N ghq-fzf-widget
      bindkey '\e[71;9u' ghq-fzf-widget
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
