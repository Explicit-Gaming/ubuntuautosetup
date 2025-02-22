#!/bin/bash

# ---- COULEURS ---- #
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}--- Mise à jour du système ---${NC}"
sudo apt update && sudo apt upgrade -y

echo -e "${GREEN}--- Configuration du systeme ---${NC}"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.peripherals.mouse speed -0.4921875
sudo sed -i 's|^Exec=gnome-terminal|Exec=gnome-terminal --geometry=150x40|' /usr/share/applications/org.gnome.Terminal.desktop
sudo apt-get purge bcmwl-kernel-source 
sudo update-pciids
sudo apt install firmware-b43-installer -y
sudo apt install linux-firmware -y
sudo modprobe -r b43
sudo modprobe b43    
sudo rfkill unblock all 

sudo mkdir -p ~/.config/autostart

echo -e "[Desktop Entry]\nType=Application\nExec=flatpak run com.obsproject.Studio --startreplaybuffer\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[en_CA]=OBS Studio\nName=OBS Studio\nComment[en_CA]=record/stream\nComment=record/stream" > ~/autostart-obs.desktop
echo -e "[Desktop Entry]\nType=Application\nExec=flatpak run eu.betterbird.Betterbird\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[en_CA]=Betterbird\nName=Betterbird\nComment[en_CA]=Best mail client\nComment=email" > ~/betterbird.desktop

echo -e "${GREEN}--- Installation des paquets essentiels ---${NC}"
sudo apt install -y curl git
sudo dpkg --add-architecture i386
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt update
sudo apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio -y


echo -e "${GREEN}--- Installation des applis essentiels ---${NC}"
sudo snap install deadbeef-vs
flatpak install flathub com.google.Chrome -y
flatpak install flathub eu.betterbird.Betterbird -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.shotcut.Shotcut -y
flatpak install flathub org.libreoffice.LibreOffice -y
flatpak install flathub com.ktechpit.ultimate-media-downloader -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub io.github.mpobaschnig.Vaults -y
flatpak install flathub io.github.alainm23.planify -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub net.krafting.PleasureDVR -y
flatpak install flathub org.gnome.Weather -y

echo -e "${GREEN}--- Nettoyage du système ---${NC}"
sudo apt autoremove -y
sudo apt autoclean

echo -e "${GREEN}✔️  Configuration terminée ! Redémarre pour appliquer tous les changements. REBOOTING !!!${NC}"
sudo reboot
