{ appimageTools, fetchurl, ... }:
let
  pname = "zen";
  version = "latest";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen-x86_64.AppImage";
    sha256 = "sha256-aIZt2RUGjVFEF1VzeaKNhkQgusoqGrQTdzGisbg+GgM=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/zen.desktop $out/share/applications/${pname}.desktop
    install -m 444 -D ${appimageContents}/zen.png $out/share/icons/hicolor/128x128/apps/${pname}.png
  '';

  meta = {
    platforms = [ "x86_64-linux" ];
  };
}
