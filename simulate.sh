#!/bin/sh
source config.sh
echo "***************************************************************************"   
echo "*                    Compiling a simulation version                       *"   
echo "***************************************************************************"
echo "please wait .... compiling ..."   
echo $PWD/$FILENAME_TEST    
"$PATH_ADT" -package -target ipa-test-interpreter -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass $PASSWORD $FILENAME_TEST $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf -platformsdk $PATH_SDK
echo "done"