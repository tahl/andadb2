#!/bin/bash
#
#Android ADB Installer 2 for Linux Mint 11 and Ubuntu 11.04
#This version is intended to be an improvement on previous version and give the user more installation options and bring more ease to people that want to develop,
#theme, or just whatever other purpose you may want to use something that is in my script for.
#Script written by @ArchDukeDoug and parts of @_CorCor67's scripting code used with permission as well. 
#ApkManager used with permission by Daneshm90 @ xda-developers.com (http://forum.xda-developers.com/showthread.php?t=695701)
#ThemeR Studio used with permission by CorCor67 @ http://corcor67.blogspot.com/p/themer-studio.html
#Thanks to @BoneyNicole, @tabbwabb, and @animedbz16 for putting up with me and proofreading and/or testing the script.
#Script version: 2.0.0
i=$(cat /proc/$PPID/cmdline)
if [[ $UID != 0 ]]; then
    echo "Please type sudo $0 $*to use this."
    exit 1
fi
menu=
until [ "$menu" = "0" ]; do
clear
echo ""
echo "***************************************************"
echo "**            Android ADB Installer 2            **"
echo "**                   Main Menu                   **"
echo "***************************************************"
echo "**  1 - Full Install - Android SDK, NDK, Eclipse **"
echo "**    - ADB, 99-android.rules, and dependencies. **"
echo "**  2 - Custom Install/Uninstall                 **"
echo "**  3 - ThemeR Studio by CorCor67                **"
echo "**  4 - Apk Manager 4.7 by Daneshm90             **"
echo "**  5 -                                          **"
echo "**  6 -                                          **"
echo "**  7 -                                          **"
echo "**  8 -                                          **"
echo "**  9 - Help                                     **"
echo "**  0 - Exit                                     **"
echo "***************************************************"
echo ""
echo -n "Enter selection: "
read menu
echo ""
case $menu in
#############################################################
#############################################################
1 )
#Determine if the operating system is 32 or 64-bit and then install ia32-libs if necessary.
d=ia32-libs

if [[ `getconf LONG_BIT` = "64" ]]; 

then
    echo "64-bit operating system detected.  Checking to see if $d is installed."

    if [[ $(dpkg-query -f'${Status}' --show $d 2>/dev/null) = *\ installed ]]; then
    	echo "$d already installed."
    else
        echo "Installing now..."
    	apt-get --force-yes -y install $d
    fi
else
	echo "32-bit operating system detected.  Skipping."
fi
#Check if Sun-Java6-JRE is installed
c=sun-java6-jre
	echo "checking if $c is installed" 2>&1
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; 
then
	echo "$c already installed.  Skipping."
else 
echo $c shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install --yes $c
fi

#Check if Sun-Java6-JDK is installed
c=sun-java6-jdk
	echo "checking if $c is installed" 2>&1
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; 
then
	echo "$c already installed.  Skipping."
else 
echo $c shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install --yes $c
fi

#Check if Eclipse is installed
c=eclipse
	echo "checking if $c is installed" 2>&1
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; 
then
	echo "$c already installed.  Skipping."
else 
	echo "$c was not found, installing..." 2>&1
	apt-get --force-yes -y install $c 2>/dev/null
fi
#Check if p7zip-full is installed
c=p7zip-full
	echo "checking if $c is installed" 2>&1
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; 
then
	echo "$c already installed.  Skipping."
else 
	echo "$c was not found, installing..." 2>&1
	apt-get --force-yes -y install $c 2>/dev/null
fi
#Check if sox is installed
c=sox
	echo "checking if $c is installed" 2>&1
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; 
then
	echo "$c already installed.  Skipping."
else 
	echo "$c was not found, installing..." 2>&1
	apt-get --force-yes -y install $c 2>/dev/null
fi
#Download and install the Android SDK.
if [ ! -d "/usr/local/android-sdk" ]; then
	for a in $( wget -qO- http://developer.android.com/sdk/index.html | egrep -o "http://dl.google.com[^\"']*linux_x86.tgz" ); do 
		wget $a && tar --wildcards --no-anchored -xvzf android-sdk_*-linux_x86.tgz; mv android-sdk-linux_x86 /usr/local/android-sdk; chmod 777 -R /usr/local/android-sdk; rm android-sdk_*-linux_x86.tgz;
	done
else
     echo "Android SDK already installed to /usr/local/android-sdk.  Skipping."
fi
#Download and install the Android NDK.
if [ ! -d "/usr/local/android-ndk" ]; then 
	for b in $(  wget -qO- http://developer.android.com/sdk/ndk/index.html | egrep -o "http://dl.google.com[^\"']*linux-x86.tar.bz2"
 ); do wget $b && tar --wildcards --no-anchored -xjvf android-ndk-*-linux-x86.tar.bz2; mv android-ndk-*/ /usr/local/android-ndk; chmod 777 -R /usr/local/android-ndk; rm android-ndk-*-linux-x86.tar.bz2;
	done
else
    echo "Android NDK already installed to /usr/local/android-ndk.  Skipping."
fi
#Create Symlink for Dalvik Debug Monitor Server (DDMS)
if [ -f /bin/ddms ] 
then
    rm /bin/ddms; ln -s /usr/local/android-sdk/tools/ddms /bin/ddms
else
    ln -s /usr/local/android-sdk/tools/ddms /bin/ddms
fi
#Create a symlink for Android Debug Bridge (adb)
if [ -f /bin/adb ]
then
    rm /bin/adb; ln -s /usr/local/android-sdk/platform-tools/adb /bin/adb
else
    ln -s /usr/local/android-sdk/platform-tools/adb /bin/adb
fi
#Installing adb!
if [ ! -f "/usr/local/android-sdk/platform-tools/adb" ];
then
nohup /usr/local/android-sdk/tools/android update sdk > /dev/null 2>&1 &
else
echo "Android Debug Bridge already detected."
fi
#Downloads the latest version of 99-android.rules
wget http://dl.dropbox.com/u/4413349/scripts/99-android.rules
mv -f 99-android.rules /etc/udev/rules.d/
;;
#############################################################
#############################################################
2 )
clear
{
cd extras && chmod +x custom.sh && ./custom.sh
}
exit 
;;
#############################################################
#############################################################
3 )
clear
{
cd extras && chmod +x -R themerstudio && cd themerstudio && ./setup.sh
}
exit 
;;
#############################################################
#############################################################
4 )
clear
{
cd extras && chmod +x -R apkmanager && cd apkmanager && ./Script.sh
}
exit 
;;
#############################################################
#############################################################

#############################################################
#############################################################

#############################################################
#############################################################

#############################################################
#############################################################

#############################################################
#############################################################
9 )
clear
echo "1 - This option will automatically install everything required for the Android SDK, NDK, and Android Debug Bridge (adb), Eclipse, and download your 99-android.rules file."
echo "2 - Takes you to the Custom installation / uninstall menu for the dependencies, Android SDK, NDK, ADB, and allows you to manually download and update your 99-android.rules file."
echo "3 - This option takes you to CorCor67's ThemeR Studio."
echo "4 - This option takes you to Daneshm90's Apk Manager 4.7."
echo "0 - Exits the installer"
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
0 ) exit ;;
* ) echo "Please choose from the list above"
	esac
done

