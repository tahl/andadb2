#!/bin/bash
#
#Android ADB Installer 2 for Linux Mint 11 and Ubuntu 11.04
#Script written by @ArchDukeDoug
#Thanks to @BoneyNicole, @tabbwabb, and @animedbz16 for putting up with me and proofreading and/or testing the script.
menu=
until [ "$menu" = "0" ]; do
clear
echo ""
echo "***************************************************"
echo "**            Android ADB Installer 2            **"
echo "**                Custom Installer               **"
echo "***************************************************"
echo "**  1 - Resolve dependencies   ( Run this first )**"
echo "**  2 - Install the Android SDK                  **"
echo "**  3 - Install the Android NDK                  **"
echo "**  4 - Install Android Debug Bridge (adb)       **"
echo "**    - Requires dependencies and Android SDK    **"
echo "**  5 - Create/update the 99-android.rules file  **"
echo "**                                               **"
echo "**  8 - Uninstall Options                        **"
echo "**  9 - Help                                     **"
echo "**  0 - Return                                   **"
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
;;
#############################################################
#############################################################
2 )
#Download and install the Android SDK.
if [ ! -d "/usr/local/android-sdk" ]; then
	for a in $( wget -qO- http://developer.android.com/sdk/index.html | egrep -o "http://dl.google.com[^\"']*linux_x86.tgz" ); do 
		wget $a && tar --wildcards --no-anchored -xvzf android-sdk_*-linux_x86.tgz; mv android-sdk-linux_x86 /usr/local/android-sdk; chmod 777 -R /usr/local/android-sdk; rm android-sdk_*-linux_x86.tgz;
	done
else
     echo "Android SDK already installed to /usr/local/android-sdk.  Skipping."
fi
;;
#############################################################
#############################################################
3 )
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
;;
#############################################################
#############################################################
4 )
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
;;
#############################################################
#############################################################
5 )
#Downloads the latest version of 99-android.rules
wget http://dl.dropbox.com/u/4413349/scripts/99-android.rules
mv -f 99-android.rules /etc/udev/rules.d/
;;
#############################################################
#############################################################
8 ) 
clear
{
chmod +x uninstall.sh && ./uninstall.sh
}
exit ;;
#############################################################
#############################################################
9 )
clear
echo "1 - This option will resolve the missing dependencies required for the Android SDK, NDK, and Android Debug Bridge (adb) to function properly."
echo "2 - Installs the Android SDK to the location /usr/local/android-sdk"
echo "3 - Installs the Android NDK to the location /usr/local/android/ndk"
echo "4 - Installs the Android Debug Bridge.  Requires Android SDK and Dependencies."
echo "5 - Downloads or updates your 99-android.rules file to /etc/udev/rules.d/ directory"
echo "6 - Automates steps 1-6."
echo "7 - Takes you to the Extras menu."
echo "8 - Takes you to the Uninstall menu."
echo "Please press enter to continue."
read enter
;;
#############################################################
#############################################################
0 ) 
clear
{
cd .. && ./andadb.sh
}
exit ;;
#############################################################
#############################################################
* ) echo "Please choose from the list above"
	esac
done

