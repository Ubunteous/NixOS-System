{ config, lib, ... }:

with lib;
let
  cfg = config.lab.k3s;
  labcfg = config.lab;
in {

  options.lab.k3s = { enable = mkEnableOption "Enables support for k3s"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    networking.firewall.allowedTCPPorts = [
      6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    ];
    # networking.firewall.allowedUDPPorts = [
    #   # 8472 # k3s, flannel: required if using multi-node for inter-node networking
    # ];

    # users.users.${user}.packages = with pkgs; [ kubernetes-helm ];

    services.k3s = {
      enable = true;
      role = "server"; # or agent

      # tokenFile
      # configPath
      # environmentFile

      # serverAddr = "https://10.0.0.10:6443";

      # extraFlags = see below
      # toString [ "--debug" ];
      # "--no-deploy traefik --cluster-cidr 10.24.0.0/16";
      # "--cluster-cidr=10.42.0.0/16,2a10:3781:25ac:2::/64 --service-cidr=10.43.0.0/16,2a10:3781:25ac:3::/112 --flannel-iface eno1";

      # disableAgent = true;
      # role = "agent"; # defaults to "server"

      #################
      # DOCKER IMAGES #
      #################

      # images = [
      #   (pkgs.dockerTools.pullImage {
      #     imageName = "docker.io/bitnami/keycloak";
      #     imageDigest =
      #       "sha256:714dfadc66a8e3adea6609bda350345bd3711657b7ef3cf2e8015b526bac2d6b";
      #     hash = "sha256-IM2BLZ0EdKIZcRWOtuFY9TogZJXCpKtPZnMnPsGlq0Y=";
      #     finalImageTag = "21.1.2-debian-11-r0";
      #   })

      #   config.services.k3s.package.airgapImages
      # ];

      ###############
      # HELM CHARTS #
      ###############

      # autoDeployChart = {
      #   harbor = {
      #     name = "harbor";
      #     repo = "https://helm.goharbor.io";
      #     version = "1.14.0";
      #     hash = "sha256-fMP7q1MIbvzPGS9My91vbQ1d3OJMjwc+o8YE/BXZaYU=";
      #     values = {
      #       existingSecretAdminPassword = "harbor-admin";
      #       expose = {
      #         tls = {
      #           enabled = true;
      #           certSource = "secret";
      #           secret.secretName = "my-tls-secret";
      #         };
      #         ingress = {
      #           hosts.core = "example.com";
      #           className = "nginx";
      #         };
      #       };
      #     };
      #   };

      #   custom-chart = {
      #     package = ../charts/my-chart.tgz;
      #     values = ../values/my-values.yaml;
      #     extraFieldDefinitions = { spec.timeout = "60s"; };
      #   };
      # };

      # services.k3s.charts.nginx = ../charts/my-nginx-chart.tgz;

      #############
      # MANIFESTS #
      #############

      # manifests = {
      #   deployment.source = ../manifests/deployment.yaml;
      #   my-service = {
      #     enable = false;
      #     target = "app-service.yaml";
      #     content = {
      #       apiVersion = "v1";
      #       kind = "Service";
      #       metadata = { name = "app-service"; };
      #       spec = {
      #         selector = { "app.kubernetes.io/name" = "MyApp"; };
      #         ports = [{
      #           name = "name-of-service-port";
      #           protocol = "TCP";
      #           port = 80;
      #           targetPort = "http-web-svc";
      #         }];
      #       };
      #     };
      #   };

      #   nginx.content = [
      #     {
      #       apiVersion = "v1";
      #       kind = "Pod";
      #       metadata = {
      #         name = "nginx";
      #         labels = { "app.kubernetes.io/name" = "MyApp"; };
      #       };
      #       spec = {
      #         containers = [{
      #           name = "nginx";
      #           image = "nginx:1.14.2";
      #           ports = [{
      #             containerPort = 80;
      #             name = "http-web-svc";
      #           }];
      #         }];
      #       };
      #     }
      #     {
      #       apiVersion = "v1";
      #       kind = "Service";
      #       metadata = { name = "nginx-service"; };
      #       spec = {
      #         selector = { "app.kubernetes.io/name" = "MyApp"; };
      #         ports = [{
      #           name = "name-of-service-port";
      #           protocol = "TCP";
      #           port = 80;
      #           targetPort = "http-web-svc";
      #         }];
      #       };
      #     }
      #   ];
      # };
    };
  };
}
