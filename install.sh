#!/bin/bash

set -e

if ! grep -q ID=debian /etc/os-release; then
    echo "It looks like you're not using Debian. This script is designed for Debian 10"
    echo "Buster only, and your /etc/os-release file says that your distro is different."

    exit 1
fi

if ! [[ $EUID -eq 0 ]]; then
    echo "Sorry, please run this script as root. Stick a sudo at the start!"

    exit 1
fi

if [ -z $1 ]; then
    echo "Please enter the directory to copy config files too. It's best to add ~ to the"
    echo "end of the last command you ran to invoke this script!"

    exit 1
fi

clear

echo "You're about to install the VoltOS dotfiles into \`$1\`!"
echo "Here's a rundown of what will happen:"
echo "- Install the LXDE desktop environment and customise its startup routine to"
echo "  launch the PCManFM desktop, Polybar and mpd"
echo "- Install the Polybar panel with the VoltOS theme"
echo "- Install the Rofi app launcher with the VoltOS theme"
echo "- Install Music Player Daemon (mpd) for playing audio"
echo "- Install the ncmpcpp music player with a few small changes"
echo "- Install galculator, which is a good calculator (also VoltOS-themed!)"
echo "- Copy in the Overpass, Overpass Mono and Noto Color Emoji fonts"
echo "- Update the font cache so these fonts can be displayed"
echo "- Copy the config files (this won't delete any of your personal files, but make"
echo "  sure to do a backup!) and theme a few other programs whilst we're at it"
echo "- Ding a bell if you're afk so that you don't fall asleep when it's all done!"
echo ""
echo "A few things to note:"
echo "- This script is designed for Debian 10 Buster only. It may work on other"
echo "  distros, though."
echo "- You'll need to learn the keyboard shortcuts to launch stuff. They're well-"
echo "  designed though (in my opinion, anyway)!"
echo "- Some config files will need to be changed if things break for your system."
echo ""
echo "When you're ready, press the enter key to start the installation!"
echo -n "If you want to cancel at any time (or now), press Ctrl + C."
read

echo ""

echo "Installing required software..."

echo "- lxde (the desktop environment)"
apt-get install -y lxde > /dev/null

echo "- polybar (the panel)"
apt-get install -y polybar > /dev/null

echo "- rofi (the app launcher)"
apt-get install -y rofi > /dev/null

echo "- mpd (for music)"
apt-get install -y mpd > /dev/null

echo "- ncmpcpp (for music)"
apt-get install -y ncmpcpp > /dev/null

echo "- galculator (it's a good calculator)"
apt-get install -y galculator > /dev/null

echo ""

echo "Updating font cache..."
fc-cache -fv > /dev/null

echo ""

echo "If you want to install Oomox for theme customisation, visit the installation"
echo "instructions at https://github.com/themix-project/oomox#debian-ubuntu-linux-mint"

echo ""

echo "Installing VoltOS dotfiles into \`$1\`..."

cp -R . $1

echo ""

echo "All done! Beeping so that you're no longer afk..."

tput bel && sleep 0.2 && tput bel && sleep 0.2 && tput bel

echo "It's time to restart your system to apply all changes! To restart, press"
echo "the enter key."
echo -n "To cancel, just press Ctrl + C."
read

reboot