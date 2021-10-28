echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

#git clone "https://github.com/DanielTolentino/.dotfiles"
chsh -s /usr/bin/fish
ln -s "$HOME/.dotfiles/fish" $HOME/.config/
ln -s "$HOME/.dotfiles/kitty" $HOME/.config/
ln -s "$HOME/.dotfiles/.doom.d" $HOME/


PKGS=(
'authy-desktop-win32-bin'
'auto-cpufreq'
'awesome-terminal-fonts'
'brave-bin' # Brave Browser
'chrome-gnome-shell'
'dxvk-bin' # DXVK DirectX to Vulcan
'github-desktop-bin' # Github Desktop sync
'gnome-shell-extension-pop-shell-git'
'iriunwebcam-bin'
'pop-launcher-git'
'pop-shell-shortcuts-git'
'rclone-browser'
'timeshift'
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-ms-fonts'
'ttf-roboto'
'ulauncher'
'visual-studio-code-bin'
'whatsapp-for-linux'
'zoom' # video conferences
'zramd'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done
echo -e "\nDone!\n"
exit
