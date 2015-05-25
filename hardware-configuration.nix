# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/afdf6e21-4a64-41dd-bdd3-558dcca1aa93";
      fsType = "ext4";
    };

  swapDevices = [ ];

  nix.maxJobs = 1;
  services.virtualboxGuest.enable = true;
}
