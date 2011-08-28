#!/bin/bash
#
#
#
uninstall=
until [ "$uninstall" = "0" ]; do
clear
echo "***************************************************"
echo "**            Android ADB Installer 2            **"
echo "**                 Uninstall Menu                **"
echo "***************************************************"
echo "** 1 - Delete Android SDK (includes ADB)         **"
echo "** 2 - Delete Android NDK                        **"
echo "** 3 - Remove 99-android.rules                   **"
echo "** 4 - Uninstall Eclipse                         **"
echo "** 5 - Uninstall Sun-Java6-JRE                   **"
echo "** 6 - Uninstall Sun6-Java6-JDK                  **"
echo "** 7 - Uninstall Sox                             **"
echo "** 8 - Uninstall p7zip-full                      **"
echo "** 9 - Main Menu                                 **"
echo "** 0 - Quit                                      **"
echo "***************************************************"
echo ""
echo -n "Enter selection: "
read uninstall
echo ""
case $uninstall in
#############################################################
#############################################################
1 ) 
rm -rf /usr/local/android-sdk
echo "Android SDK successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
2 ) 
rm -rf /usr/local/android-ndk
echo "Android NDK successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
3 )
rm /etc/udev/rules.d/99-android.rules
echo "99-android.rules successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
4 )
apt-get --force-yes -y remove eclipse
echo "Eclipse successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
5 )
apt-get --force-yes -y remove sun-java6-jre
echo "Sun-Java6-JRE successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
6 )
apt-get --force-yes -y remove sun-java6-jdk
echo "Sun-Java6-JDK successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
7 )
apt-get --force-yes -y remove sox
echo "Sox successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
8 )
apt-get --force-yes -y remove p7zip-full
echo "p7zip-full successfully removed."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
9 ) 
clear
{
cd .. && ./andadb.sh
}
exit ;;
#############################################################
#############################################################
0 ) exit ;;
* ) echo "Please choose from the list above"
	esac
done

