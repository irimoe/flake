{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "iris";
    userEmail = "iri@iri.moe";

    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
}
