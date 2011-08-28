#!/bin/bash
# Backup & Restore Android Workspace v1.0
# By CorCor67
# v1.0 Original Release


selection=
until [ "$selection" = "0" ]; do
clear
echo ""
echo "***************************************************"
echo "**             Android ThemeR Studio             **"
echo "**              64-bit Theme Engine              **"
echo "***************************************************"
echo "**  1 - Download Programs Needed                 **"
echo "**  2 - Reboot --> (Do after step 1 & before 3)  **"
echo "**  2 - Setup Workspace & sync repos             **"
echo "**  3 - Build                                    **"
echo "**                                               **"
echo "**  0 - Exit Menu                                **"
echo "***************************************************"
echo ""
echo -n "Enter selection: "
read selection
echo ""
case $selection in

#*********************************************************************
1 ) clear
echo "Installing programs..."
sudo apt-get update
sudo apt-get install git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.6-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev sun-java6-jdk pngcrush schedtool g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline5-dev gcc-4.3-multilib g++-4.3-multilib
mkdir -p "$HOME/bin"
curl "http://android.git.kernel.org/repo" > "$HOME/bin/repo"
chmod u+rwx "$HOME/bin/repo"
;;

2 ) clear 
sudo reboot
 ;;

3 ) clear
mkdir -p "$HOME/Android/ThemeEngine"
cd "$HOME/Android/ThemeEngine"
repo init -u git://github.com/tmobile/themes-platform-manifest.git -b master
repo sync
source build/envsetup.sh
lunch themes_generic-eng hdpi
;;

4 ) clear
mkdir -p "$HOME/Android/ThemeEngine/vendor/tmobile/themes"
cd "$HOME/Android/ThemeEngine/vendor/tmobile/themes"
git clone git://github.com/haxzamatic/Templatebread-.git
;;

5 ) clear
make
;;

6 ) clear
firefox "http://code.google.com/p/android-theme/wiki/TMobileThemeEngine"
;;
0 ) exit ;;
* ) echo "Please enter a number from the list above"
    esac
done
