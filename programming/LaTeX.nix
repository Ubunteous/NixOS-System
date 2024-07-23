{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.latex;
  langcfg = config.languages;
in {
  options.languages.latex = {
    enable =
      mkEnableOption "Enables support for the LaTeX programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs;
        [
          # ghostscript # for latex images/equations with preview-region
          # texlab # lsp

          # texpresso # live editing

          # autoconf # for auctex build with elpaca
          # auctex

          (texlive.combine {
            inherit (texlive)
            # scheme-basic # base (but not minimal)
              scheme-small # for missing mf command
              comment

              # fullpage missing => maybe in bigger scheme like
              # [T1]fontenc => old font. don't use it. lmodern is better

              # improved appearance
              # microtype

              # oad
              pdfpages ulem fp changepage xcolor pdflscape

              # cv
              fontawesome
              # hyperref

              # org
              dvipng # essential
              # wrapfig
              # capt-of
              # kpathsea
              # metafont
              parskip listings

              # presentations
              # beamer
              # beamertheme-metropolis
              # pgfopts # metropolis dependency
              # lmodern # already available as a metropolis dependency

              # wallpaper
              # everypage
              # background
              # xkeyval # background dependency

              # csv
              # csvsimple
              # siunitx
              # datatool

              # misc
              enumitem
              # forest
              ragged2e preprint # corresponds to fullpage package
              # caption
              # pgfgantt
              # extsizes
              # multirow
              # biblatex
              # biber
            ;
          })
        ];
    };
  };
}
