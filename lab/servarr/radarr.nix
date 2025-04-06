{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.lab.radarr;
  labcfg = config.lab;
in {
  options.lab.radarr = {
    enable = mkEnableOption "Enables support for radarr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.radarr = {
      enable = true;

      # user = "radarr";
      group = "multimedia";

      openFirewall = true;
      # dataDir = "/var/lib/radarr/.config/Radarr";
    };
  };
}

# systemd.tmpfiles.rules = let
# config.xml = pkgs.writeText "config.xml" ''
#         <Config>
#         <BindAddress>*</BindAddress>
#         <Port>7878</Port>
#         <SslPort>9898</SslPort>
#         <EnableSsl>False</EnableSsl>
#         <LaunchBrowser>True</LaunchBrowser>
#         <ApiKey>many numbers</ApiKey>
#         <AuthenticationMethod>Forms</AuthenticationMethod>
#         <AuthenticationRequired>DisabledForLocalAddresses</AuthenticationRequired>
#         <Branch>master</Branch>
#         <LogLevel>info</LogLevel>
#         <SslCertPath></SslCertPath>
#         <SslCertPassword></SslCertPassword>
#         <UrlBase></UrlBase>
#         <InstanceName>Radarr</InstanceName>
#         <AnalyticsEnabled>True</AnalyticsEnabled>
#       </Config>
#     '';
#   in [ "L /var/lib/radarr/.config/Radarr/test.xml - - - - ${config.xml}" ];
