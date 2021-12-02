echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

#git clone "https://github.com/DanielTolentino/.dotfiles"
chsh -s /usr/bin/fish
#sh -c "$(curl -fsSL https://starship.rs/install.sh)"
ln -s "$HOME/.dotfiles/fish" $HOME/.config/
ln -s "$HOME/.dotfiles/kitty" $HOME/.config/
#rm -r "$HOME/.doom.d"
#ln -s "$HOME/.dotfiles/.doom.d" $HOME/
#doom sync

PKGS=(
'authy-desktop-win32-bin'
'auto-cpufreq'
'awesome-terminal-fonts'
'chrome-gnome-shell'
'dxvk-bin' # DXVK DirectX to Vulcan
'github-desktop-bin' # Github Desktop sync
'iriunwebcam-bin'
'rclone-browser'
'timeshift'
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-ms-fonts'
'ttf-roboto'
'visual-studio-code-bin'
'zoom' # video conferences
'zramd'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

gsettings reset org.gnome.shell app-picker-layout 

echo -e "\nDone!\n"
exit
