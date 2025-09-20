{ config, lib, ... }:

with lib;
let
  cfg = config.lab.routing;
  corecfg = config.lab;
in {

  options.lab.routing = {
    enable = mkEnableOption "Enables support for rounting";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    # TODO: get a physical router and setup interfaces for real

    #########################
    # BASIC TROUBLESHOOTING #
    #########################

    # # Check interface status
    # ip link show
    # ip addr show

    # # Monitor DHCP leases
    # journalctl -u dnsmasq -f

    # # View active DHCP leases
    # cat /var/lib/dnsmasq/dnsmasq.leases

    # # Check firewall rules
    # sudo nft list ruleset

    # # Watch packet flow
    # sudo tcpdump -i enp2s0 -n

    # No internet on LAN devices?
    # Verify NAT is working: sudo iptables -t nat -L -v -n
    # Check IP forwarding: sysctl net.ipv4.ip_forward

    # DHCP not working?
    # Ensure dnsmasq is running: systemctl status dnsmasq
    # Check logs: journalctl -u dnsmasq
    # View leases: cat /var/lib/dnsmasq/dnsmasq.leases

    # Can’t access router via SSH?
    # Verify firewall allows SSH from LAN: sudo iptables -L -v -n

    ##########
    # KERNEL #
    ##########

    boot.kernel = {
      sysctl = {
        # stop discarding network packets that are not destined
        # for the interface on which they were received
        # => enable ip forwarding for ipv4
        "net.ipv4.conf.all.forwarding" = true;
        "net.ipv6.conf.all.forwarding" = false;

        # filter martian packets with rp_filter
        "net.ipv4.conf.default.rp_filter" = 1;
        "net.ipv4.conf.wan.rp_filter" = 1;
        # "net.ipv4.conf.br-lan.rp_filter" = 0;
      };
    };

    ###########
    # NETWORK #
    ###########

    systemd.network = {
      wait-online.anyInterface = true;

      netdevs = {
        # Create the bridge interface
        "20-br-lan" = {
          netdevConfig = {
            Kind = "bridge";
            Name = "br-lan";
          };
        };
      };

      networks = {
        # "xx-lanx" = {
        #   matchConfig.Name = "lan0";
        #   linkConfig.RequiredForOnline = "enslaved";
        #   networkConfig = {
        # 	ConfigureWithoutCarrier = true;
        #   };
        # };
        "wlp1s0" = {
          # get interfaces with ip link show (at least lan+wan)
          # check their state with networkctl
          matchConfig.Name = "wan";
          networkConfig = {
            # start a DHCP Client for IPv4 Addressing/Routing
            DHCP = "ipv4";
            DNSOverTLS = true;
            DNSSEC = true;
            # IPv6PrivacyExtensions = false;
            # IPForward = true;
          };
          # make routing on this interface a dependency for network-online.target
          linkConfig.RequiredForOnline = "routable";
        };
      };
    };

    ###########
    # DNSMASK #
    ###########

    services.dnsmasq = {
      enable = true;
      settings = {
        # upstream DNS servers
        server = [ "9.9.9.9" "8.8.8.8" "1.1.1.1" ];
        # sensible behaviours
        domain-needed = true;
        bogus-priv = true;
        no-resolv = true;

        # Cache dns queries.
        cache-size = 1000;

        dhcp-range = [ "br-lan,192.168.10.50,192.168.10.254,24h" ];
        interface = "br-lan";
        dhcp-host = "192.168.10.1";

        # local domains
        local = "/lan/";
        domain = "lan"; # example.com
        expand-hosts = true;

        # don't use /etc/hosts as this would advertise surfer as localhost
        no-hosts = true;
        address = "/surfer.lan/192.168.10.1";

        dhcp-option = [
          "option:router,192.168.1.1"
          "option:dns-server,192.168.1.1" # Use router as DNS server
        ];

        # interfaces.enp2s1.ipv4.addresses = [{
        #   address = "192.168.1.2";
        #   prefixLength = 28;
        # }];
        # vlans = {
        #   vlan100 = { id=100; interface="enp2s0"; };
        #   vlan101 = { id=101; interface="enp2s0"; };
        # };
        # interfaces.vlan100.ipv4.addresses = [{
        #   address = "10.1.1.2";
        #   prefixLength = 24;
        # }];
        # interfaces.vlan101.ipv4.addresses = [{
        #   address = "10.10.10.3";
        #   prefixLength = 24;
        # }];
        # defaultGateway = "192.168.1.1";
        # nameservers = [ "1.1.1.1" "8.8.8.8" ];
      };
    };

    networking = {
      # # find real interfaces name with ip a command
      # interfaces = {
      # 	"eth0" = {
      #     # DHCP needed to acquire IP for WAN
      #     useDHCP = true;
      # 	};
      # 	"eth1" = {
      #     # Static IP needed for LAN gateway
      #     useDHCP = false;
      #     ipv4.addresses = [{
      # 		address = "192.168.0.1";
      # 		prefixLength = 24;
      #     }];
      # 	};
      # };

      # hostName = "surfer";
      # hosts = {
      # 	"127.0.0.1" = [ "foo.bar.baz" ];
      # 	"192.168.0.2" = [ "fileserver.local" "nameserver.local" ];
      # };

      useNetworkd = true;
      useDHCP = false;

      #######
      # NAT #
      #######

      nat = {
        enable = false;
        externalInterface = "enp1s0"; # WAN
        internalInterfaces = [ "enp2s0" ]; # LAN
        forwardPorts = [{
          sourcePort = 80;
          proto = "tcp";
          destination = "10.100.0.3:80";
        }];
      };

      ############
      # FIREWALL #
      ############

      #   # Simple firewall rules
      #   firewall = {
      # 	enable = false; # may conflict with ntfables

      # 	# Allow SSH from LAN only
      # 	extraCommands = ''
      #       iptables -A nixos-fw -p tcp --dport 22 -s 192.168.1.0/24 -j ACCEPT
      # 	'';
      #   };
      # };

      ############
      # NFTABLES #
      ############

      nftables = {
        enable = true;
        ruleset = ''
          table ip nat {
                    chain PREROUTING {
                      type nat hook prerouting priority dstnat; policy accept;
                      iifname "ens3" tcp dport 80 dnat to 10.100.0.3:80
                    }
                  }
        '';
      };
    };

    # # more complete
    # nftables = {
    #   enable = true;
    #   tables = {
    #     # Allow select IPv4 traffic
    #     filterV4 = {
    #       family = "ip";
    #       content = ''
    #         chain input {
    #           type filter hook input priority 0; policy drop;
    #           iifname "lo" accept comment "allow loopback traffic"
    #           iifname "eth1" accept comment "allow traffic from LAN"
    #           iifname "eth0" ct state established, related accept comment "allow established traffic from WAN"
    #           iifname "eth0" ip protocol icmp counter accept comment "allow ICMP traffic from WAN" 
    #           iifname "eth0" tcp dport 22 counter accept comment "allow SSH traffic from WAN"
    #           iifname "eth0" counter drop comment "drop all other traffic from WAN"
    #         }
    #         chain forward {
    #           type filter hook forward priority 0; policy drop;
    #           iifname "eth1" oifname "eth0" accept comment "allow LAN connections to forward to WAN"
    #           iifname "eth0" oifname "eth1" ct state established, related accept comment "allow established WAN connections to forward to LAN"
    #         }
    #       '';
    #     };
    #     # Allow forwarded traffic out through WAN, masquerades IP
    #     natV4 = {
    #       family = "ip";
    #       content = ''
    #         chain postrouting {
    #           type nat hook postrouting priority 100; policy accept;
    #           oifname "eth0" masquerade comment "replace source address with WAN IP address"
    #         }
    #       '';
    #     };
    #     # Drops all IPv6 traffic
    #     filterV6 = {
    #       family = "ip6";
    #       content = ''
    #         chain input {
    #           type filter hook input priority 0; policy drop;
    #         }
    #         chain forward {
    #           type filter hook forward priority 0; policy drop;
    #         }
    #       '';
    #     };
    #   };
    # };

    ##############
    # KEA (DHCP) #
    ##############

    # # DHCP server for LAN
    # services.kea.dhcp4 = {
    #   enable = true;
    #   settings = {
    #     interfaces-config.interfaces = [ "eth1" ];

    #     lease-database = {
    #       name = "/var/lib/kea/dhcp4-leases.csv";
    #       type = "memfile";
    #       persist = true;
    #       lfc-interval = 3600;
    #     };

    #     valid-lifetime = 4000;
    #     renew-timer = 1000;
    #     rebind-timer = 2000;

    #     subnet4 = [{
    #       id = 1;
    #       subnet = "192.168.0.0/24";
    #       pools = [{ pool = "192.168.0.16 - 192.168.0.128"; }];

    #       option-data = [
    #         {
    #           name = "routers";
    #           data = "192.168.0.1";
    #         }
    #         {
    #           name = "domain-name-servers";
    #           data = "1.1.1.1"; # Cloudflare DNS
    #         }
    #       ];
    #     }];
    #   };
    # };

    ###########
    # HOSTAPD #
    ###########

    services.hostapd = {
      enable = true;
      radios = {
        wlan0 = {
          band = "2g";
          countryCode = "FR";
          channel = 0; # ACS

          wifi4.enable = true;

          networks = {
            wlan0 = {
              ssid = "wifi-name";
              authentication = {
                mode = "none"; # "wpa3-sae"
                # put this in sops/agenix when use it for real
                saePasswordsFile = null; # null or absolute path
              };
              bssid = "36:b9:ff:ff:ff:ff";
              settings = { bridge = "br-lan"; };
            };
          };
        };
      };
    };
  };
}
