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
    userName = "Daniel Steman";
    userEmail = "daniel.steman@billygrace.com";
    settings = {
      core.editor = "vim";
      core.excludesFile = "~/.gitignore_global";

      push.autoSetupRemote = true;
      pull.rebase = false;
      fetch.prune = true;

      diff.algorithm = "histogram";
      diff.colorMoved = "default";

      merge.conflictstyle = "zdiff3";

      branch.sort = "-committerdate";
      tag.sort = "-version:refname";

      alias.um = "!git fetch origin main && git merge origin/main -m \"🔀 Merge origin/main into $(git rev-parse --abbrev-ref HEAD)\"";
    };
  };

  # User-specific packages organized by category
  home.packages = with pkgs; let
    # Cloud & Infrastructure tools
    cloud = [
      auth0-cli
      awscli2
      azure-cli
      databricks-cli
      fluxcd
      kubernetes-helm
      kubectl
      kubectx
      kind
      localstack
      packer
      trivy
    ];

    # Development languages & runtimes
    languages = [
      bun
      deno
      go
      lua
      nodejs_24
      postgresql_16
      sqlite
      typescript
      zig
    ];

    # Python development tools
    python = [
      mypy
      pdm
      pipenv
      (poetry.withPlugins (p: [ p.poetry-plugin-export ]))
      pre-commit
      pyenv
      pyright
      tenv
      uv
      yamllint
    ];

    # Development tools & editors
    devTools = [
      bfg-repo-cleaner
      chromedriver
      code-cursor
      commitizen
      direnv
      fzf
      gh
      gitmoji-cli
      neovim
      prettierd
      vim
      vscode
    ];

    # Git & version control
    gitTools = [
      act
      jira-cli-go
    ];

    # Container & orchestration
    containers = [
      colima
      docker
      process-compose
    ];

    # Security & encryption
    security = [
      age
      gnupg
      mkcert
      sops
    ];

    # System utilities
    systemUtils = [
      ansible
      cue
      htop
      jq
      neofetch
      nmap
      tree
      wget
      websocat
      xz
      yq
      zstd
    ];

    # GUI applications
    guiApps = [
      aerospace
      firefox
      kitty
      monitorcontrol
      raycast
      spotify-qt
    ];

    # Other tools
    misc = [
      cmatrix
      goose-cli
      ngrok
      ollama
      temporal-cli
      wimlib
      yarn
    ];
  in
    cloud
    ++ languages
    ++ python
    ++ devTools
    ++ gitTools
    ++ containers
    ++ security
    ++ systemUtils
    ++ guiApps
    ++ misc;
}
