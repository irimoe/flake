{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  autoPatchelfHook,
  alsa-lib,
  libxkbcommon,
  wayland,
  xorg,
  libGL,
  libX11,
  libXext,
  gtk3,
  fontconfig,
  freetype,
  vulkan-loader,
}:

stdenv.mkDerivation rec {
  pname = "zed";
  version = "0.181.7";

  src = fetchurl {
    url = "https://github.com/zed-industries/zed/releases/download/v${version}/zed-linux-x86_64.tar.gz";
    sha256 = "sha256-q6IrE21nyytgYGe0pTkvE24uferWZchV0ITTCZvJhtU=";
  };

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];

  buildInputs = [
    alsa-lib
    libxkbcommon
    wayland
    xorg.libxcb
    xorg.libXrender
    xorg.libXfixes
    xorg.libXcomposite
    libGL
    libX11
    libXext
    gtk3
    fontconfig
    freetype
    stdenv.cc.cc.lib
    vulkan-loader
  ];

  dontPatchELF = true;

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib/zed
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/512x512/apps

    tar -xvf $src
    cp -r zed.app/* $out/lib/zed/

    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${lib.makeLibraryPath buildInputs}" \
        $out/lib/zed/bin/zed

    makeWrapper $out/lib/zed/bin/zed $out/bin/zeditor \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
        --set WINIT_UNIX_BACKEND "x11" \
        --set LD_PRELOAD "${vulkan-loader}/lib/libvulkan.so.1"

    cat > $out/share/applications/zed.desktop << EOF
    [Desktop Entry]
    Name=Zed Editor
    Comment=High-performance, multiplayer code editor
    Exec=/usr/bin/env bash -c 'touch ~/.config/zed/env && source ~/.config/zed/env && $out/bin/zeditor'
    Icon=$out/lib/zed/share/icons/hicolor/512x512/apps/zed.png
    Terminal=false
    Type=Application
    Categories=Development;TextEditor;
    StartupWMClass=Zed
    EOF

    cp $out/lib/zed/share/icons/hicolor/512x512/apps/zed.png $out/share/icons/hicolor/512x512/apps/zed.png
  '';

  meta = with lib; {
    description = "High-performance, multiplayer code editor from the creators of Atom and Tree-sitter";
    homepage = "https://zed.dev";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "zed";
  };
}
