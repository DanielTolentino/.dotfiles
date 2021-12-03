echo -e "\nFINAL SETUP AND CONFIGURATION"
echo -e "\nEnabling essential services"

#systemctl enable cups.service
#sudo systemctl enable NetworkManager.service
sudo systemctl enable --now zramd
sudo systemctl enable auto-cpufreq
sudo systemctl start auto-cpufreq
echo "Finished"
exit
