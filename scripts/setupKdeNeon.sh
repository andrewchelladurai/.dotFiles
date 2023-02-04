#
# For Ubuntu Based Distros (KDE Specific)
# Preferred Distro : KDE Neon : https://neon.kde.org/
#

# Download the dotFiles repo 
mkdir ~/.dotConfigs/ && cd ~/.dotConfigs/
git clone https://github.com/andrewchelladurai/.dotConfigs.git
stow -nvR home-dir/ config-dir/
# Validate that the links are all present
ls -la ~/ ~/.config/ | grep -i '^l' | tr -s " " | cut -d" " -f 9-11

# Reload the modifications or open a terminal to load the new .bashrc file
source ~/.bashrc

# Make links to actual content directories in a separate partition
# Required only if the data partition is on a separate partition from OS mount-point
rmdir ~/Documents/ ~/Downloads/ ~/Pictures/ ~/Videos/ ~/Music/
ln -s /media/$(whoami)/Data/Documents/ Documents
ln -s /media/$(whoami)/Data/Downloads/ Downloads
ln -s /media/$(whoami)/Data/Volatile/ Volatile
ln -s /media/$(whoami)/Media/Music/ Music
ln -s /media/$(whoami)/Media/Pictures/ Pictures
ln -s /media/$(whoami)/Media/Movies/ Videos

# Download required Nerd fonts :
# https://www.nerdfonts.com/font-downloads
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
# and place it in ~/.local/share/fonts/
# 
# DejaVuSansMono
# FiraCode
# JetBrainsMono
# Noto
# SourceCodePro
#
# Remove the unecessary font families from the extracts
find . -type f -iname \*Windows*ttf -delete
find . -type f -iname \*Mono.ttf -delete
find . -type f -iname \*Semi*ttf -delete
find . -type f -iname \*Extra*ttf -delete
find . -type f -iname \*Black*ttf -delete
find . -type f -iname \*Light*ttf -delete
find . -type f -iname \*Medium*ttf -delete
find . -type f -iname \*Thin*ttf -delete
find . -type f -iname \*otf -delete
find . -type f -iname \*Retina*ttf -delete
find . -type f -iname \*Ext*ttf -delete
rm Noto*Emoji*ttf Noto*Condensed*ttf Noto*Display*ttf

# Remove all the unnecesary packages from the fresh-install
TO-DO

# Now do a dist-upgrade
upgradesys

# For capability to add PPA repositories
sudo apt install -y software-properties-common software-properties-qt

# PPA : Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# PPA : Enpass.io (Password manager)
sudo sh -c 'echo "deb http://repo.sinew.in/ stable main" >> /etc/apt/sources.list.d/enpass.list'
wget -O - http://repo.sinew.in/keys/enpass-linux.key | sudo apt-key add -

# Download and Install Unified Remote Server
wget https://www.unifiedremote.com/download/linux-x64-deb && sudo dpkg --install linux-x64-deb

# Download and install Nordvpn
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb && sudo dpkg -i nordvpn*.deb

# Install Syncthing : https://syncthing.net/downloads/
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -

# Download and install the latest release of ActivityWatch Timetracker
https://github.com/ActivityWatch/activitywatch/releases

# Install the bashtop system monitor : https://github.com/aristocratos/bashtop | https://packages.azlux.fr/
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
# alternate PPA : sudo add-apt-repository ppa:bashtop-monitor/bashtop && sudo apt install bashtop


# For Android AVD emulation performance, installl KVM packages for Linux
# https://developer.android.com/studio/run/emulator-acceleration?utm_source=android-studio#vm-linux
sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo adduser $(whoami) kvm

# Install necessary apps
sudo apt install -y ktorrent kdiff3 kubuntu-restricted-extras git vlc virtualbox virtualbox-guest-additions-iso kget sqlite filelight gimp google-chrome-stable enpass inkscape digikam xserver-xorg-input-synaptics nordvpn wireguard neovim default-jdk bashtop kate
sudo apt-get install -y --no-install-recommends libreoffice

# Install proprietary drivers
sudo ubuntu-drivers autoinstall

# This is for a Wifi Card Bug on HP Pavilion Notebook AB219TX (N8L68PA#ACJ)
# have'nt observred WiFi drops for quite some time
# DO not think this is required any more, however keeping it for records sake.
# sudo sh -c 'echo "options rtl8723be fwlps=0 swlps=0 ips=0 ant_sel=1" >> /etc/modprobe.d/rtl8723be.conf'

# For bug that shows the extra user on the login screen
# sudo usermod -u 999 libvirt-qemu

# For manually mounting HDD's by label - Use this in the user profile if needed
# Was required for ElementaryOs Luna because of a bug
# Not sure if still needed, keeping for recod's sake
# udisksctl mount -b /dev/disk/by-label/Data