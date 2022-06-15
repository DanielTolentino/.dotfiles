echo -e "\nInstalling Base System\n"
PKGS=(
'adobe-source-code-pro-fonts'
'adobe-source-han-sans-cn-fonts'
'adobe-source-han-sans-jp-fonts'
'adobe-source-han-sans-kr-fonts' 
'akm'
'alacritty'
'arc-gtk-theme'
'automake' # build
'base'
'bash-completion'
'bat'
'bind'
'binutils'
'bison'
'cmake'
'cups'
'curl'
'dhcpcd'
'dmenu'
'exa'
'exfat-utils'
'fd'
'fish'
'flatpak'
'gcc'
'gedit'
'gimp' # Photo editing
'git'
'glances'
'gnome-keyring'
'gnupg'
'gnutls'
'gparted' # partition management
'gptfdisk'
'gst-libav'
'htop'
'i3-gaps'
'i3lock'
'intel-gpu-tools'
'kitty'
'make'
'micro'
'mpv'
'neofetch'
'network-manager-applet'
'networkmanager'
'nitrogen'
'noto-fonts-emoji'
'noto-fonts'
'openssh'
'pacman-contrib'
'patch'
'pcmanfm'
'pkgconf'
'qemu'
'ranger'
'rofi'
'rsync'
'stow'
'telegram-desktop'
'terminus-font'
'tmux'
'ttf-bitstream-vera'
'ttf-dejavu'
'ttf-fira-code'
'ttf-liberation'
'ttf-ms-fonts'
'ttf-nerd-fonts-symbols'
'ttf-opensans' 
'unrar'
'unzip'
'usbutils'
'vim'
'vlc'
'wget'
'which'
'xf86-video-inte'
'xfce4-power-manager'
'xfce4-power-manager'
'zip'
#'os-prober'
#'steam'
#'toolbox'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
echo -e "\nDone!\n"
exit
