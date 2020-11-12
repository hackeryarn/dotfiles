{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../nixos/shared.nix
  ];

  virtualisation.docker.enable = true;

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.19.49.2/24" "2001:db8:a160::2/48" ];
      privateKeyFile = "/home/artem/.wireguard/darterpro";

      peers = [{
        publicKey = "GfeBlnYoSyqRiCLPOWvo0mgqN7w5idLn/wpCZ1MGjy0=";
        presharedKey = "4lKbgB/O2mwMNTQeAD5wcHzn5oQkUsHaEWvJBwsd42w=";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        endpoint = "164.90.154.100:51820";
        persistentKeepalive = 25;
      }];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.artem = {
    isNormalUser = true;
    home = "/home/artem";
    description = "Artem Chernyak";
    extraGroups = [
      "wheel"
      "networkmanager"
      "disk"
      "audio"
      "video"
      "systemd-journal"
      "docker"
    ];
  };
}
