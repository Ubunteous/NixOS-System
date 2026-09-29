{
  config,
  lib,
  pkgs,
  user,
  ...
}:

with lib;
let
  cfg = config.languages.common-lisp;
  langcfg = config.languages;
in
{
  options.languages.common-lisp = {
    enable = mkEnableOption "Enables support for the Common Lisp programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = [
        # pkgs.asdf # bundled with sbcl. see modern variant ocicl
        # pkgs.roswell # image manager

        # import packages this way:
        # nix-shell -p sbcl --run sbcl
        # * (load (sb-ext:posix-getenv "ASDF"))
        # * (asdf:load-system 'alexandria)

        (pkgs.sbcl.withPackages (
          ps: with ps; [
            # cl-strings

            eazy-gnuplot # gnuplot interface

            #########
            # debug #
            #########

            log4cl
            # log4cl_dot_log4slime
            fiveam # unit tests

            #######
            # cli #
            #######

            clingon # cli
            # tuition # tui

            ##########
            # regexp #
            ##########

            cl-ppcre
            # one-more-re-nightmare

            #######
            # sql #
            #######

            postmodern # for pg
            # mito # orm
            sxql # sql generator
            # sqlite # cl-sqlite

            #############
            # datafiles #
            #############

            cl-csv
            jzon

            #############
            # utilities #
            #############

            # alexandria # utilities
            # serapeum # supplementary utilities
            # anaphora # macros
            # arrows # clojure macros
            # trivia # pattern matching
            # fset # data structures

            ##################
            # multithreading #
            ##################

            # bordeaux-threads
            # lparallel
            # sento # known as cl-gserver. for async actors

            ########
            # http #
            ########

            fast-http
            # snooze # rest
            dexador # client

            ##########
            # server #
            ##########

            hunchentoot
            easy-routes

            # clack
            # woo
            # caveman2

            spinneret # html generator
            lass # css generators
            # djula # django styple templates
            # reblocks # or reblocks-gui. independent backend
          ]
        ))
      ];
    };
  };
}
