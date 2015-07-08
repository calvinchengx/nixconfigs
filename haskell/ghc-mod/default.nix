{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7101" }:
nixpkgs.haskell.packages.${compiler}.callPackage ./ghc-mod.nix { }
