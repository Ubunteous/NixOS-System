{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    ##############
    #   Python   #
    ##############
      
    packages = with pkgs; [
      black # linter
      # black-macchiato # format partial files
      mypy # static type checker
      sphinx # documentation
      
      # cannot build from source with current ram
      # python3Packages.tensorflow / tensorflowWithCuda

      conda
      
      (let
        my-python-packages = python-packages: with python-packages; [
          requests

          # Data Science
          numpy
          matplotlib           
          pandas
          scipy
          scikit-learn

          # AMLS
          opencv4 # import as cv2 
          dlib
          keras
          tqdm
          scikitimage # error
          # tensorflow # error => loads slowly
          
          # data formats
          h5py
          asdf

          # AI
          nltk
          pytorch
          spacy
          transformers
          tokenizers
          datasets

          # ipython
          jupyterlab
          notebook
          
          # tools
          isort
          pytest
          python-lsp-server
          pip # anaconda mode
          
          # lsp-bridge (dependencies)
          # epc
          # orjson
          # sexpdata
          # six

          # Misc
          pymupdf
          
          # screenplain # not on nix   
        ];
        python-with-my-packages = python3.withPackages my-python-packages;
      in
        python-with-my-packages)
    ];
  };
}
