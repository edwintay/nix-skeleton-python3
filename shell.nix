{
  sources ? import ./nix/sources.nix
}:

let
  pkgs = import sources.nixpkgs { };

  # build time dependencies like pip and linters
  python3-env = pkgs.python3.withPackages (pypkgs: with pypkgs; [
    # package
    pip
    setuptools

    # lint
    flake8
    pylint
  ]);
  # run time dependencies will be in ./requirements.txt
in

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.bashInteractive

    python3-env
  ];

  shellHook = ''
    unset PIP_REQUIRE_VIRTUALENV

    export PIP_PREFIX=$PWD/pip
    export PYTHONPATH="$PIP_PREFIX/lib/python3.8/site-packages''${PYTHONPATH:+:$PYTHONPATH}"
    export PATH="$PIP_PREFIX/bin''${PATH:+:$PATH}"

    # nix clobbers this for reproducible builds but pip requires this to be
    # later than 1980
    unset SOURCE_DATE_EPOCH
  '';
}
