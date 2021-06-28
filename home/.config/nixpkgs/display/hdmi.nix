# Configuration for the HDMI-2 display monitor
{ config, lib, pkgs, stdenv, ... }:

let
  base = pkgs.callPackage ../home.nix { inherit config lib pkgs stdenv; };

  hdmiBar = pkgs.callPackage ../services/polybar/bar.nix {};

  statusBar = import ../services/polybar/default.nix {
    inherit config pkgs;
    mainBar = hdmiBar;
    openCalendar = "${pkgs.gnome3.gnome-calendar}/bin/gnome-calendar";
  };

  terminal  = import ../programs/alacritty/default.nix { fontSize = 10; inherit pkgs; };
in
{
  imports = [
    ../home.nix
    statusBar
    terminal
  ];

  home.packages = base.home.packages;
}
