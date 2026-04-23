{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.packages.security;
  usercfg = config.user;
in {
  options.user.packages.srm = {
    enable = mkEnableOption "Enable security packages";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    users.users.${user}.packages = with pkgs; [
      # cli
      nmap # network discovery/auditing
      netcat-gnu # read network i/o
      tcpdump # network sniffer

      # toolkits
      autopsy # sleuth kit
      ghidra # reverse engineering
      metasploit
      armitage # metasploit frontend
      wireshark # packet sniffer
      burpsuite # web app testing

      # password cracking
      john # try johnny for gui

      # forensic
      bulk_extractor # file system information extraction

      # intelligence
      # spiderfoot # not in nixpkgs but can be installed manually
      amass # dns enumeration + network mapping

      # wifi/network
      aircrack-ng # security audit
      recon-ng # web reconnaissance
      bettercap # man in the middle
      netexec # crackmapexec fork. exploits
      responder # man in the middle

      # web app
      sqlmap # injection
      nikto # web server scanner
      whatweb # web server scanner
      ffuf # web fuzzing
    ];
  };
}
