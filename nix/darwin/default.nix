{ pkgs, username, ... }:
{
  # Nix is managed by Determinate Nix Installer
  nix.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages (available to all users)
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
  ];

  # Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # ----------------------------------------
  # macOS system defaults
  # ----------------------------------------

  # Dock
  system.defaults.dock = {
    autohide = true;
    tilesize = 48;
    show-recents = false;
    mru-spaces = false;
    expose-group-apps = true;
  };

  # Mission Control / Spaces
  system.defaults.spaces.spans-displays = false;

  system.activationScripts.postActivation.text = ''
    for key in 32 34 33 35 79 80 81 82 118 119 120 121 122; do
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" \
        "<dict><key>enabled</key><false/><key>type</key><string>standard</string><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array><key>type</key><string>standard</string></dict></dict>"
    done
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Finder
  system.defaults.finder = {
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;
    ShowPathbar = true;
    FXPreferredViewStyle = "clmv";
  };

  # Global
  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleShowAllExtensions = true;
    KeyRepeat = 2;
    InitialKeyRepeat = 15;
    AppleKeyboardUIMode = 3;
    "com.apple.swipescrolldirection" = true;
  };

  # Trackpad
  system.defaults.trackpad = {
    Clicking = true;
    TrackpadThreeFingerDrag = true;
  };

  # ----------------------------------------
  # Homebrew casks (shared)
  # ----------------------------------------
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "nikitabobko/tap/aerospace"
      "docker-desktop"
      "google-chrome"
      "google-japanese-ime"
      "hammerspoon"
      "homerow"
      "dbeaver-community"
    ];
  };

  # ----------------------------------------
  # Auto-start applications
  # ----------------------------------------
  launchd.user.agents.homerow = {
    serviceConfig = {
      Label = "com.dexterleng.homerow.launcher";
      ProgramArguments = [ "/Applications/Homerow.app/Contents/MacOS/Homerow" ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };

  # Primary user
  system.primaryUser = username;

  # User
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  system.stateVersion = 5;
}
