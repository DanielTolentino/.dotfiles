echo -e "\nInstalling Flatpaks\n"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

PKGS=(
'Adwaita'
'Bottles'
'Builder'
'Byte'
'Codecs'
'default'
'Evince'
'Foliate'
'Freedesktop'
'GNOME'
'GNU'
'i386'
'KDE'
'Kdenlive'
'LibreOffice'
'Manual'
'Markets'
'Mesa'
'openh264'
'PDF'
'QGnomePlatform'
'QGnomePlatform-decoration'
'QtSNI'
'Rust'
'Spotify'
'Stremio'
'SWH'
'TAP-plugins'
'Transmission'
'ungoogled-chromium'
'WhiteSur-dark'
'WhiteSur-dark-solid'
'WhiteSur-light'
'WhiteSur-light-solid'
'Zoom'
)
for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    flatpak install "$PKG" --noconfirm --needed
done
echo -e "\nDone!\n"
exit
