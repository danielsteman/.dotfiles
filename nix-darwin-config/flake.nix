{
  description = "My configuration for macOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        aerospace
        aws-sam-cli
        awscli2
        code-cursor
        colima
        commitizen
        cmatrix
        cue
        docker
        firefox
        fzf
        gh
        gnupg
        go
        jira-cli-go
        jq
        kitty
        lua
        localstack
        neofetch
        neovim
        nerd-fonts.hack
        pgadmin4
        pipenv
        (poetry.withPlugins (p: [ p.poetry-plugin-export ]))
        pre-commit
        prettierd
        pyenv
        pyright
        raycast
        rustc
        rustfmt
        rustup
        sketchybar
        spotify
        sqlite
        terraform
        tree
        typescript
        uv
        vim
        vscode
        websocat
        xz
        yarn
        yq
      ];

      nix.enable = false;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set primary user
      system.primaryUser = "danielsteman";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;
      environment.shells = [ pkgs.bash pkgs.zsh ];

      # Fonts stuff
      fonts.packages = [
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.nerd-fonts.meslo-lg
      ];

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Unlock sudo commands with our fingerprint.
      security.pam.services.sudo_local.touchIdAuth = true;

      system.defaults = {
        trackpad.Clicking = true;
        dock.autohide = true;
        screencapture.target = "clipboard";

        finder = {
          AppleShowAllExtensions = true;
          ShowPathbar = true;
          FXEnableExtensionChangeWarning = false;
        };
      };

      system.keyboard.enableKeyMapping = true;

      system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."danielsteman" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
