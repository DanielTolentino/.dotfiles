echo -e "\nInstalling Flatpaks\n"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

PKGS=(
'Bottles'
'Builder'
'Byte'
'Evince'
'Foliate'
'Kdenlive'
'LibreOffice'
'Markets'
'PDF'
'Spotify'
'Stremio'
'Transmission'
'ungoogled-chromium'
'Zoom'
)
for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    flatpak install "$PKG"
done
echo -e "\nDone!\n"
exit
