#!/bin/bash
# Credit Links v1.0
# By CorCor67
# v1.0 Original Release

selection=
until [ "$selection" = "0" ]; do
clear
echo ""
echo "***************************************************"
echo "**             Android ThemeR Studio             **"
echo "**             Information & Credits             **"
echo "***************************************************"
echo "**  1 - ThemeR Studio Home Page    (Report bugs?)**"
echo "**  2 - CorCor67 on Twitter        (Report bugs?)**"
echo "**  3 - ApkManager thread on XDA                 **"
echo "**  4 - Apkopt thread on XDA                     **"
echo "**  5 - Donate to ThemeR Studio development      **"
echo "**                                               **" 
echo "**  6 - Credits & Thank Yous                     **" 
echo "**                                               **" 
echo "**  0 - Return                                   **"
echo "***************************************************"
echo ""
echo -n "Enter selection: "
read selection
echo ""
case $selection in

#*********************************************************************
1 ) firefox 'http://corcor67.blogspot.com/p/themer-studio.html' ;;
2 ) firefox 'http://twitter.com/_corcor67' ;;
3 ) firefox 'http://forum.xda-developers.com/showthread.php?t=695701' ;;
4 ) firefox 'http://forum.xda-developers.com/archive/index.php/t-560271.html' ;;
5 ) firefox 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=H2HM52CBYMR8C' ;;
#*********************************************************************
6 ) clear
echo "=================================Credits=============================="
echo ""
echo "Most of these scripts were built by CorCor67 Any that were not,  were"
echo "modified with extra options and to work with my ThemeR Studio tools"
echo ""
echo "Apkopt original author coolbho3000 | Port to Linux-?"
echo ""
echo "ApkManager original author Daneshm90 | Port to Linux farmatito"
echo ""
echo "Thanks to the following for the help testing & debugging"
echo "nmiltner"
echo "bgill55"
echo "Kookahdoo" 
echo "mjones1052"
echo ""
echo ""
echo "When you're ready to return to the menu press enter"
echo ""
read enter
;;
#*********************************************************************
0 ) 
clear
{
    cd .. && ./setup.sh && exit;
}
exit ;;
#*********************************************************************
* ) echo "Please enter a number from the list above"
    esac
done
