{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.python;
  langcfg = config.languages;
in {
  options.languages.python = {
    enable =
      mkEnableOption "Enables support for the Python programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        # black # linter
        # black-macchiato # format partial files
        mypy # static type checker
        pylint
        # sphinx # documentation
        ruff # fast linter
        # ruff-lsp # ruff for lsp server
        pyright

        # cannot build from source with current ram
        # python3Packages.tensorflow

        (let
          my-python-packages = python-packages:
            with python-packages; [
              pynvim # for deoplete-nvim

              # pillow # PIL for embuary

              pip # necessary for emacs anaconda mode
              # python-lsp-server
              # isort
              # tools
              # pytest
              debugpy
              # pylama # neovim

              django
              # requests
              # gdtoolkit

              # Data Science
              numpy
              matplotlib
              pandas
              scipy
              # scikit-learn

              # AMLS
              # opencv4 # import as cv2 
              # dlib
              # keras
              # tqdm
              # scikitimage # error
              # tensorflow # error => loads slowly

              # data formats
              # h5py
              # asdf

              # AI
              # nltk
              # pytorch
              # spacy
              # spacy-transformers
              # transformers
              # tokenizers
              # datasets

              # ipython
              jupyterlab
              # notebook
              # ipywidgets # for TQDM warnings

              # lsp-bridge (dependencies)
              # epc
              # orjson
              # sexpdata
              # six

              # Misc
              # pymupdf
              # tabulate # for pandas dataframes in org mode

              # screenplain # not on nix

              # youtube-dl # alternative: yt-dlp
            ];
          python-with-my-packages = python3.withPackages my-python-packages;
        in python-with-my-packages)
      ];
    };
  };
}
