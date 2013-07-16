#!/bin/sh
source config.sh
echo "***************************************************************************"        
echo "*                       Install & load simulation                         *"        
echo "***************************************************************************"
echo "please wait ... installing ..." 
echo $PWD/$FILENAME_TEST
"$PATH_ADT" -installApp -platform ios -platformsdk $PATH_SDK -device ios-simulator -package $FILENAME_TEST
echo "please wait ... loading ..."
"$PATH_ADT" -launchApp -platform ios -platformsdk $PATH_SDK -device ios-simulator -appid $ID
echo "done."