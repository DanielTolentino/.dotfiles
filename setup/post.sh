echo -e "\nFINAL SETUP AND CONFIGURATION"
echo -e "\nEnabling essential services"

systemctl enable cups.service
sudo ntpd -qg
sudo systemctl enable ntpd.service
sudo systemctl disable dhcpcd.service
sudo systemctl stop dhcpcd.service
sudo systemctl enable NetworkManager.service
sudo systemctl enable --now zramd
sudo systemctl start auto-cpufreq
sudo systemctl enable auto-cpufreq
echo "Finished"
exit
