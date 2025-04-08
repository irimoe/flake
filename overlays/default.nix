{
  default = final: prev: {
    customPackages = import ../pkgs/derivations { pkgs = final; };
  };
}
