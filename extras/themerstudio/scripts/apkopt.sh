#!/bin/bash
# Script was downloaded from (http://www.mediafire.com/?n05mzcnznyl)
# As far as I can find the original author is coolbho3000
# Link to thread on XDA (http://forum.xda-developers.com/archive/index.php/t-560271.html)

# Script was modified by CorCor67 to run with ThemeR Studio package
# Also added the option for user to define compression and optimization levels
# Sets path variables (for ThemeR Studio) so the user doesn't have to edit .bashrc

PATH="$PATH:$HOME/.ThemeRStudioToolz"
export PATH
#echo $PATH
# Test for needed programs and warn if missing
ERROR="0"
for PROGRAM in "optipng" "7za" "java" "sudo" "sox"
do
	which "$PROGRAM" > /dev/null 
	if [ "x$?" = "x1" ] ; then
		ERROR="1"
		echo "The program $PROGRAM is missing or is not in your PATH,"
		echo "please install it or fix your PATH variable"
	fi
done

# Select compression level,  default to 4 if no option is selected
{
	echo ""
        echo ""
	echo "Would you like to change the compression level?"
	echo "Choose (y) to change or (n) to use the default level of 4"
	printf "%s" "Please make your decision: "
	read RETVAL


	if [ "x$RETVAL" = "xy" ] || [ "x$RETVAL" = "xY" ] ; then
		echo "Compression can be any number 0-9 note that higher compression may cause issues"
                echo -n "Please choose compression level"
                echo ""
                read compression
case $compression in
           [0-9]) if [[ $compression -eq $compression ]]
           then
echo ""
           fi  ;;

           *) compression=4
echo "Invalid entry compression has been set to default" ;;
esac

	elif [ "x$RETVAL" = "xn" ] || [ "x$RETVAL" = "xN" ] ; then
		echo ""
	fi
}
if [ -z "$compression" ]
then
   compression="4"
fi
echo "Compression level has been set to $compression"


# Select png optimization level,  default to 4 if none is selected

{
	echo ""
        echo ""
	echo "Would you like to change the png optimization level?"
	echo "Choose (y) to change or (n) to use the default level of 4"
	printf "%s" "Please make your decision: "
	read yon
	if [ "x$yon" = "xy" ] || [ "x$yon" = "xY" ] ; then
		echo "Compression can be any number 0-7 note that higher optimization may distort your colors"
                echo -n "Please choose optimization level"
                echo ""
                read opt

case $opt in
           [0-7]) if [[ $opt -eq $opt ]]
           then
echo ""
           fi  ;;

           *) opt=4
echo "Invalid entry compression has been set to default" ;;
esac

	elif [ "x$yon" = "xn" ] || [ "x$yon" = "xN" ] ; then
		echo ""
	fi
}
if [ -z "$opt" ]
then
   opt="4"
fi
echo "PNG optimization level has been set to $opt"
sleep 3



# Run it in /system/app dir -(You don't have to)
# create temporary and final output directory
# (MOD)- Temp directory made hidden,  output directory renamed to Optimized

mkdir -p .tmp
mkdir -p Optimized
# Loop through the apk files
for i in `ls *.apk`
do 
	# Print original size
	size=`du -h $i`
	echo -n "Processing $size"
	name=`basename $i .apk`
# (MOD) Make backup of original apks
mkdir -p Original
cp -i $name.apk Original
	# Clean up stale files from previous killed runs
	rm  -fr .tmp/* 
	cp $i .tmp
	cd .tmp
	unzip -q $i
	cp ../$i $name.zip
	# Generate list of the files to be compressed
	list=`find | cut -b 3- | grep -v apk |grep -v zip`
	for a in $list
	do
		# Do not process directories
		if [ ! -d $a ] ; then 
			# Try to optimize png files.
			# Needs optipng
			infile=`ls $a | grep '\.png$'`
			if [ -n "$infile" ] ; then
# (MOD) optipng set to -o4 (-o0 is minimum optimization -07 is maximum optimization)
# -o0 will take much less time to process than -o7,  but -o7 will result in smaller file sizes
				optipng -o$opt $a
			fi
			# Try to optimize a ogg files. 
			# Needs sox
			infile=`ls $a | grep '\.ogg$'`
			if [ -n "$infile" ] ; then
				sox  $a -C 0 temp.ogg
				if [ -e temp.ogg ] ; then
					rm $a
					mv temp.ogg $a
				fi
			fi
			#Try to optimize a gif files.
			# Needs ImageMagick.
			infile=`ls $a | grep '\.gif$'`
			if [ -n "$infile" ] ; then
				convert $a -fuzz 5% -layers Optimize temp.gif
				if [ -e temp.gif ] ; then
					rm $a
					mv temp.gif $a
				fi
			fi
		fi
	done
	# Recompress 
	# Needs p7zip-full package
# -mx is compression level, (0-9) 0 being no compression 9 being max
# -mx9 will take much longer to process than -mx0
	7za a -tzip -mx$compression $name.zip $list 2>&1> /dev/null
	# If you want to resign the apk packages
	# but it seems not to be needed.
	# Needs Signapk package
	#java -jar ../signapk.jar ../testkey.x509.pem ../testkey.pk8 $name.zip $name.apk
	#mv $name.zip ../Optimized/$name.apk
	# Run zipalign instead of mv'ing the apk.
	zipalign -v 4 $name.zip ../Optimized/$name.apk
	# Clean up
	rm -R *
	# Print new size
	size=`du -h ../Optimized/$name.apk`
	echo " ==> $size";
	cd ..
done
