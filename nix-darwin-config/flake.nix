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
    lib = nixpkgs.lib;
    username = "danielsteman";
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        aerospace
        ansible
        auth0-cli
        awscli2
        azure-cli
        bfg-repo-cleaner
        bun
        code-cursor
        colima
        commitizen
        chatgpt
        cmatrix
        cue
        chromedriver
        databricks-cli
        deno
        direnv
        docker
        firefox
        fzf
        htop
        gh
        gitmoji-cli
        gnupg
        go
        jira-cli-go
        jq
        kind
        kitty
        kubectl
        kubernetes-helm
        lua
        localstack
        mkcert
        monitorcontrol
        mypy
        neofetch
        neovim
        nerd-fonts.hack
        nodejs_24
        ngrok
        pdm
        pipenv
        (poetry.withPlugins (p: [ p.poetry-plugin-export ]))
        pre-commit
        prettierd
        process-compose
        postgresql_16
        pyenv
        pyright
        raycast
        sketchybar
        spotify-qt
        sqlite
        temporal-cli
        tenv
        tree
        trivy
        typescript
        uv
        vim
        vscode
        websocat
        wget
        wimlib
        xz
        yarn
        yq
        zig
      ];

      nix.enable = false;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set primary user
      system.primaryUser = username;

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
    darwinConfigurations."${username}" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."${username}" = {
            imports = [ ./home.nix ];
            home.homeDirectory = lib.mkForce "/Users/${username}";
          };
        }
      ];
    };

    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [ ./home.nix ];
    };
  };
}
