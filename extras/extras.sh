#!/bin/bash
#
#
#
extras=
until [ "$extras" = "0" ]; do
clear
echo "***************************************************"
echo "**            Android ADB Installer 2            **"
echo "**                  Extras Menu                  **"
echo "***************************************************"
echo "** 1 - ThemeR Studio by CorCor67                 **"
echo "** 2 - Apk Manager Setup ( Run me first )        **"
echo "** 2 - Apk Manager 4.7 by Daneshm90              **"
echo "** 3 - Install Apk Manager                       **"
echo "** 0 - Return                                    **"
echo "***************************************************"
echo ""
echo -n "Enter selection: "
read extras
echo ""
case $extras in
#############################################################
#############################################################
1 ) 
clear
{
chmod +x -R themerstudio && cd themerstudio && ./setup.sh
}
exit ;;
#############################################################
#############################################################
2 ) clear
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

ln -s /usr/local/android-sdk/platform-tools/adb `pwd`/other/adb
;;

#############################################################
#############################################################


3 )
clear
{
chmod +x -R apkmanager && cd apkmanager && ./Script.sh
}
exit ;;
#############################################################
#############################################################
0 ) 
clear
{
cd .. && ./andadb.sh
}
exit ;;

* ) echo "Please choose from the list above"
	esac
done

