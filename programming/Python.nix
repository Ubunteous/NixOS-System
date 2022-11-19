{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    ##############
    #   Python   #
    ##############

    packages = with pkgs; [
      black # linter
      # black-macchiato # format partial files
      mypy
      sphinx
      (let
        my-python-packages = python-packages: with python-packages; [
          requests

          # Data Science
          numpy
          matplotlib           
          pandas
          scipy
          scikit-learn

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
          
          # tensorflow
          # screenplain # not on nix   
        ];
        python-with-my-packages = python3.withPackages my-python-packages;
      in
        python-with-my-packages)
      
    ];
  };
}
