{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "iris";
    userEmail = "iris@heyiris.dev";
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
}
