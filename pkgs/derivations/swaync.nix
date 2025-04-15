{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "swaync";
  version = "0.11.0";

  src = pkgs.fetchFromGitHub {
    owner = "ErikReider";
    repo = "SwayNotificationCenter";
    rev = "v${version}";
    sha256 = "1i6b8562llmj38fgbpdw2i50ki03chlb8ywbgci1smsbn1hv05li";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    vala
    pkg-config
    scdoc
    sassc
    git
    wrapGAppsHook
    gobject-introspection
    python3
    wayland-scanner
  ];

  buildInputs = with pkgs; [
    gtk3
    gtk-layer-shell
    dbus
    glib
    libgee
    json-glib
    libhandy
    gvfs
    pantheon.granite
    libpulseaudio
  ];

  mesonFlags = [
    "-Dsystemd-service=true"
    "-Dscripting=true"
    "-Dpulse-audio=true"
    "-Dman-pages=true"
    "-Dzsh-completions=true"
    "-Dbash-completions=true"
    "-Dfish-completions=true"
  ];

  dontWrapGApps = false;

  postPatch = ''
    chmod +x build-aux/meson/postinstall.py
    substituteInPlace build-aux/meson/postinstall.py \
      --replace "/usr/bin/env python3" "${pkgs.python3}/bin/python3"
  '';

  meta = with pkgs.lib; {
    description = "A simple notification daemon with a GTK gui for notifications and the control center";
    homepage = "https://github.com/ErikReider/SwayNotificationCenter";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    mainProgram = "swaync";
  };
}
