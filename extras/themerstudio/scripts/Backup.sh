#!/bin/bash
# Backup & Restore Android Workspace v1.0
# By CorCor67
# v1.0 Original Release


selection=
until [ "$selection" = "0" ]; do
clear
    echo ""
echo ""
echo "***************************************************"
echo "**             Android ThemeR Studio             **"
echo "**                Backup & Restore               **"
echo "***************************************************"
echo "**  1 - Backup theme space                       **"
echo "**  2 - Restore theme space                      **"
echo "**  3 - Backup Gimp Gradients                    **"
echo "**  4 - Restore Gimp Gradients                   **"
echo "**                                               **"
echo "**  5 - Export Backups to DropBox                **"
echo "**  6 - Import Backups from DropBox              **"
echo "**                                               **"
echo "**  7 - Get DropBox                              **"
echo "**  8 - Help                                     **"
echo "**                                               **"
echo "**  0 - Return                                   **"
echo "***************************************************"
echo ""
echo -n "Enter selection: "
read selection
echo ""
case $selection in

#*********************************************************************


1 ) 
 clear
    echo "Creating a backup of your theme space in ThemeR Studio folder..."	
7z a -mx9 $HOME/Desktop/ThemeRStudio/Backups/ThemeSpaceBackup.7z "$HOME/Android" 
chmod -R 777 $HOME/Desktop/ThemeRStudio/Backups/
;;

#*********************************************************************


2 ) clear

echo "Extracting theme space backup from ThemeR Studio..." 	
7z x -o"$HOME" $HOME/Desktop/ThemeRStudio/Backups/ThemeSpaceBackup.7z
chmod -R 777 $HOME/Android;;


#*********************************************************************

3 ) 
 clear
    echo "Creating a backup of your gradients in ThemeRStudio..."	
7z a -mx9 $HOME/Desktop/ThemeRStudio/Backups/GradientBackup.7z "$HOME/.gimp-2.6/gradients/*" 
chmod -R 777 $HOME/Desktop/ThemeRStudio/Backups/
;;



4 ) clear

echo "Extracting to your gradients folder..."	
7z e -o"$HOME/.gimp-2.6/gradients" $HOME/Desktop/ThemeRStudio/Backups/GradientBackup.7z 
chmod -R 777 $HOME/.gimp-2.6/gradients
;;


5 ) clear

echo "Exporting backups to DropBox"
mkdir -p $HOME/Dropbox/ThemeRStudio-Backups
cp "$HOME/Desktop/ThemeRStudio/Backups/GradientBackup.7z" $HOME/Dropbox/ThemeRStudio-Backups
cp "$HOME/Desktop/ThemeRStudio/Backups/ThemeSpaceBackup.7z" $HOME/Dropbox/ThemeRStudio-Backups
chmod -R 777 $HOME/Dropbox/ThemeRStudio-Backups
;;

6 ) clear

echo "Importing backups from DropBox"
mkdir -p $HOME/Desktop/ThemeRStudio-Backups
cp "$HOME/Dropbox/ThemeRStudio-Backups/GradientBackup.7z" $HOME/Desktop/ThemeRStudio-Backups
cp "$HOME/Dropbox/ThemeRStudio-Backups/ThemeSpaceBackup.7z" $HOME/Desktop/ThemeRStudio-Backups
chmod -R 777 $HOME/Desktop/ThemRStudio-Backups
;;

7 ) clear
firefox "http://db.tt/bHYl3J2"
sudo apt-get install dropbox
;;

8 ) clear
echo ""
echo ""
echo "You must have 7z installed for this script to work"
echo ""
echo ""
echo "Backups are placed in $HOME/Desktop/ThemeRStudio/Backups"
echo ""
echo ""
echo "In order for restore to work properly you need to have"
echo "the 7z in your ThemeRSetup's backup folder"
echo ""
echo ""
echo ""
echo ""
echo -n "Press enter when you're ready to move on."
    read selection
 ;;
0 ) 
clear
{
    cd .. && ./setup.sh
}
exit ;;
* ) echo "Please enter a number from the list above"
    esac
done
