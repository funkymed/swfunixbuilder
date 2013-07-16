#!/bin/sh
source config.sh
echo "***************************************************************************"     
echo "*                        making device version                            *"     
echo "***************************************************************************"
echo "Please wait ... compiling..."
echo $PWD/$FILENAME_PROD
echo "$PATH_ADT" -package -target ipa-test-interpreter -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass $PASSWORD $FILENAME_PROD $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf
echo "done."                      