let
  foo = { pkgs, pkgsi686Linux }:
  let 
    build_pkgs = pkgsi686Linux.pkgsMusl;
    build_pkgs_boost = build_pkgs.boost169.override { enableShared = false; enableStatic = true; };
  in build_pkgs.stdenv.mkDerivation {
    name = "foo";
    nativeBuildInputs = with pkgs; [
    	cmake
      git
    ];
    buildInputs = with build_pkgs; [ 
      build_pkgs_boost
    ];
    CMAKE_BOOST_PATH = build_pkgs_boost;
  };
in (import <nixpkgs> { }).callPackage foo {}
