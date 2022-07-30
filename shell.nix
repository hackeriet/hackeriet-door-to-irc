{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let perl = pkgs.perl.withPackages(p: [ p.Mojolicious p.IOSocketSSL ]);
in mkShell {
  buildInputs = [
    perl
  ];
}
