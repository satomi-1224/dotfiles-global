{ ... }:
{
  programs.git = {
    enable = true;

    ignores = [
      ".DS_Store"
      "**/settings.local.json"
    ];

    lfs.enable = true;

    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      credential.helper = "osxkeychain";
    };
  };
}
