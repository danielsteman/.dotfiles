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
      pull.rebase = false;

      alias.um = "!git fetch origin main && git merge origin/main";
    };
  };

  # User-specific packages (moved from environment.systemPackages)
  home.packages = with pkgs; [
    act
    aerospace
    age
    ansible
    auth0-cli
    awscli2
    azure-cli
    bfg-repo-cleaner
    bun
    code-cursor
    colima
    commitizen
    cmatrix
    cue
    chromedriver
    databricks-cli
    deno
    direnv
    docker
    fluxcd
    firefox
    fzf
    htop
    gh
    gitmoji-cli
    gnupg
    go
    goose-cli
    jira-cli-go
    jq
    kind
    kitty
    kubectl
    kubectx
    kubernetes-helm
    lua
    localstack
    mkcert
    monitorcontrol
    mypy
    neofetch
    neovim
    nmap
    nodejs_24
    ngrok
    ollama
    packer
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
    sops
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
    yamllint
    yarn
    yq
    zig
    zstd
  ];
}
