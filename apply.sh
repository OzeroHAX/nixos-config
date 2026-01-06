#!/usr/bin/env bash
set -e

sudo cp -f *.nix /etc/nixos/
sudo nixos-rebuild switch
