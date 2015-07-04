# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos"; # Define your hostname.
  networking.hostId = "6ea76719";
  # networking.wireless.enable = true;  # Enables wireless.
  networking.firewall.allowedTCPPorts = [ 3333 3000 8300 8400 ];
  networking.firewall.allowPing = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  nix.binaryCaches = [ http://cache.nixos.org ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    htop
    tmux
    tree
    colordiff
    silver-searcher
    vim_configurable
    gitAndTools.gitFull
    mercurialFull
    python
    nox
    nix-repl
    kde4.kdiff3
    vimPlugins.YouCompleteMe
    vimPlugins.gitgutter

    # Haskell development in vim
    vimPlugins.vimproc
    vimPlugins.vim-hdevtools
    vimPlugins.ghc-mod-vim

    # needed for vim-hdevtools
    haskellPackages.ghc
    /*haskellPackages.ghc-mod*/
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.hdevtools
    haskellPackages.yesod-bin

    # needed for compiling vimproc's shared library
    gnutar
    gnumake
    gzip
    gcc
    binutils
    coreutils
    gawk
    gnused
    gnugrep
    patchelf
    findutils

    # Example on how to add in my own package
    (import ./my-hello.nix)
  ];

  # List services that you want to enable:
  services = {

    openssh.enable = true;

    consul = {
      enable = true;
      extraConfig = {
        server = true;
        advertise_addr = "127.0.0.1";
      };
    };

    postgresql = {
        enable = true;
        package = pkgs.postgresql94;
        authentication = pkgs.lib.mkOverride 10 ''
            local all all              trust
            host  all all 127.0.0.1/32 md5
            host  all all ::1/128      md5
        '';
    };

  };
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.calvin = {
    isNormalUser = true;
    uid = 1000;
  };

}
