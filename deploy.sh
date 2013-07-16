#!/bin/sh
source config.sh
echo "***************************************************************************"    
echo "*                     Deploy test version on device                       *"    
echo "***************************************************************************"
echo "Please wait ... sending ..."        
echo $PWD/$FILENAME_PROD          
"$PATH_TRANSPORT" -v $FILENAME_PROD
echo "done."