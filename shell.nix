{
  sources ? import ./nix/sources.nix
}:

let
  pkgs = import sources.nixpkgs { };
  mach-nix = import sources.mach-nix { };
in

  mach-nix.mkPythonShell {
    requirements = (
      (builtins.readFile ./requirements.txt) +
      (builtins.readFile ./shell.txt)
    );
  }
