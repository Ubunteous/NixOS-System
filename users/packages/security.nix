{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.packages.security;
  usercfg = config.user;
in {
  options.user.packages.security = {
    enable = mkEnableOption "Enable security packages";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    users.users.${user}.packages = with pkgs; [
      # cli
      nmap # network discovery/auditing
      # netcat-gnu # read network i/o. nc already available
      tcpdump # network sniffer
      # mitm6 # network spoofing # python broken 4/2026
      # fping # faster ping with multiple targets
      nuclei # vulnerability scanner

      # toolkits
      # autopsy # sleuth kit gui
      # ghidra # reverse engineering. decompiles to c
      metasploit
      armitage # metasploit frontend
      wireshark # packet sniffer
      burpsuite # web app testing. layer 7 man in the middle

      # password recovery
      # john # try johnny for gui frontend
      # hashcat

      # forensic
      # bulk_extractor # file system information extraction
      # sleuthkit # disk images/data recovery

      # intelligence (dns enumeration/network mapping)
      # amass
      # subfinder # faster than amass
      # # sublist3r # can be installed from source
      # # spiderfoot # can be installed from source

      # wifi/network
      aircrack-ng # security audit
      recon-ng # web reconnaissance
      bettercap # man in the middle
      netexec # crackmapexec fork. exploits
      # responder # man in the middle. insanely comprehensive

      # web app/server
      sqlmap # injection
      nikto # web server scanner. plugins
      # whatweb # web server scanner. many plugins
      # ffuf # web fuzzing. flags like curl. FUZZ from file
    ];
  };
}
