{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "danielsteman";
  # home.homeDirectory is set in flake.nix

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # When using home-manager as a nix-darwin module, programs.home-manager.enable
  # is not needed - it's automatically enabled

  # Git configuration
  programs.git = {
    enable = true;
    settings = {
      push.autoSetupRemote = true;
    };
  };
}
