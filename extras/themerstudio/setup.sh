#!/bin/bash
# ThemeR Studio v1.0 (C) 2011 CorCor67
# v1.0 Initial Release
# Notice:  You are welcome to modify these scripts as you see fit,  I only ask that you keep credits to the original authors in tact.  I put a lot of work into getting these where they are and im sure the authors of ApkManager and ApkOpt both did too.  In the credits section I have included a few ways to contact me,  I would love to see any changes or improvements you might have.

selection=
until [ "$selection" = "0" ]; do
clear
echo ""
echo "***************************************************"
echo "**             Android ThemeR Studio             **"
echo "**                  by CorCor67                  **"
echo "**                   Main Menu                   **"
echo "***************************************************"
echo "**  1 - Setup tools   (Run First and only once)  **"
echo "**  2 - Build your workspace                     **"
echo "**                                               **"
echo "**  5 - Backup & Restore Menu                    **"
echo "**  6 - Set up Theme Engine                      **"
echo "**  7 - Install ThemeR Studio (for easier access)**"
echo "**  8 - Information & Credits                    **"
echo "**  9 - Help                                     **"
echo "**  0 - Return                                   **"
echo "***************************************************"
echo ""
echo -n "Enter selection: "
read selection
echo ""
case $selection in
#*********************************************************************
#*********************************************************************
1 ) 
7z x -o"$HOME" scripts/Toolz.7z  
chmod -R 777 $HOME/.ThemeRStudioToolz
echo "Setup complete.  Press enter to continue."
read enter
;;
#*********************************************************************
#*********************************************************************
2 )  clear
     echo "Creating Android workspace..." 
     mkdir -p $HOME/Android
     mkdir -p $HOME/Android/ApkManager
     mkdir -p $HOME/Android/apkopt
     mkdir -p $HOME/Android/ROMs
     mkdir -p $HOME/Android/ThemeProjects
     mkdir -p $HOME/Android/ThemeSource
   cp "/scripts/apkopt.sh" $HOME/Android/apkopt
	chmod -R 777 $HOME/Android
 ;;
#*********************************************************************
#*********************************************************************
5 ) clear
cd scripts && ./Backup.sh
 ;;
#*********************************************************************
#*********************************************************************
6 ) clear
# Detect if user has 32 or 64 bit sys and launches the appropriate script & removes the other
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
cd scripts && ./ThemeEngine64.sh
else
cd scripts && ./ThemeEngine32.sh
fi
;;
#*********************************************************************
#*********************************************************************
7 )  clear
     echo "Installing ThemeR Studio"
     mkdir -p $HOME/Android
     mkdir -p $HOME/Android/ThemerStudio
     cp setup.sh $HOME/Android/ThemerStudio
     cp scripts $HOME/Android/ThemerStudio
     chmod 777 $HOME/Android
     chmod 777 -R $HOME/Android/ThemerStudio
;;
#*********************************************************************
#*********************************************************************
8 ) clear
{
cd scripts && ./extras.sh 
}
;;
#*********************************************************************
#*********************************************************************
9 )
echo "1- Sets up tools in $HOME/.ThemerStudioToolz these tools are used by apkmanager and apkopt,  if you don't use either you don't need them"
echo ""
echo "2- Sets up a few folders to help you keep organized,  these folders are not needed and you may delete them if you don't want them.  The backup feature zips up everything in $HOME/Android/ so leave that one in place if you want to backup."
echo ""
echo "5- Backs up $HOME/Android/ and also your custom made Gimp gradients.  There is an option to export your backups to dropbox.  Also imports backups from dropbox,  and restores backups.  Great if you have multiple computers you work on or are planning on formatting your hard drive."
echo ""
echo "6- Theme Engine is a work in progress,  it downloads everything you need but isn't fully functioning yet.  Once I get it working right I'll push out an update for it.  Please remember it doesn't fully work yet!"
echo ""
echo "7- Copies the ThemeR Studio script files to $HOME/Android/ThemerStudio for easier access"
echo ""
echo "8- Information & Credits has links to report any bugs you may find,  places to find the original apkopt script used here, and a credits list."
echo ""
echo "Press enter when you're ready to go back to the menu"
read enter
;;
#*********************************************************************
#*********************************************************************
0 ) 
clear
{
cd .. && cd .. && ./andadb.sh
}
;;
* ) echo "Please enter a number from the list above"
    esac
done

