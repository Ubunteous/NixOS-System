{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.postgresql;
  langcfg = config.languages;
in {
  options.languages.postgresql = {
    enable =
      mkEnableOption "Enables support for the PostgreSQL programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        # postgresql
        # pgadmin4 # pony broken as of 3/2024
        # pgadmin4-desktopmode

        ############
        # terminal #
        ############

        # pgcenter # observe and troubleshoot
        # pgcli # use psql in a term

        # add this to .psqlrc for more informative prompts
        # \set PROMPT1 '(%n@%M:%>) %`date +%H:%M:%S` [%/] \n%x%\n'
        # \set PROMPT2 ''

        #############
        # formatter #
        #############

        pgformatter
        # sql-formatter

        #######
        # lsp #
        #######

        postgres-lsp
        # sqls

        ############
        # analyser #
        ############

        sqlfluff # linter and formatter
        # sqlcheck

        ############
        # advanced #
        ############

        # GUI
        pgweb # go. runs on port 8081

        # Schema
        # sqldef # schema management

        # Diagram
        # dbeaver-bin # generate UML
        # schemaspy
        # postgresql_jdbc
        # jailer # ugly but seems useful
        # erd

        # postgrest # rest api

        # Data analysis
        # telegraf
        # pghero
      ];
    };

    ######################
    #   DATABASE SETUP   #
    ######################

    # Create db: initdb -D .data
    # Start PostgreSQL server: pg_ctl -D .data -l logfile start # maybe requires /run/postgresql/ ?
    # Verification: pg_ctl -D .data status
    # Connection to database: psql -d postgres (by default, postgres database is created)
    # Stop database when leaving nix: pg_ctl -D .data

    # run .sql file (check database with SELECT current_database();)
    # psql -U username -d myDataBase -a -f file.sql # if remote, add: -h host
    # run psql -d myDataBase first and in shell use: \i path_to_sql_file

    # Alternative: psql -U postgres
    # \l list databases \du list users
    # psql -U postgres -c "drop database mydb" # delete mydb
    # psql -U postgres -c "drop role mydb" # delete role
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql; # 1/25. somehow fixes postgres

      # superUser = "${user}"; # "postgres";

      # authentication = pkgs.lib.mkOverride 10 ''
      authentication = ''
        #type database DBuser address      auth-method
        local all      all                 trust
        #local all     postgres            peer map=eroot

        #host  all     all    127.0.0.1/32 trust
        #host  all     all    ::1/128      trust
      '';

      #   identMap = ''
      #   eroot     root      postgres
      #   eroot     postgres  postgres
      #   eroot     ${user}   postgres
      # '';

      # settings = {};
      # port = 5432;

      # database/users need to be deleted manually
      # as NixOS does not deal with state
      # ensureDatabases = [ "${user}" ];
      # ensureUsers = [
      #   {
      #     name = "${user}";
      #     ensureDBOwnership = true;

      #     ensureClauses = {
      #       login = true;
      #       superuser = true;

      #       createrole = true;
      #       createdb = true;
      #       replication = true;
      #       bypassrls = true;
      #       # inherit = true;
      #     };
      #   }
      # ];
    };

  };
}
