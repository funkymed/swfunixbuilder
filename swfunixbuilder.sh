#!/bin/sh
source config.sh
command=$1
                                              
_title()
{      
	if test $1
	then
		echo "***************************************************************************"     
		echo "*\t\t\t"$*
		echo "***************************************************************************"
	fi                   
}

_help () { 
	_title "help"
	echo "COMMANDS :"    
	echo "help\t\t\tthis text"
	echo "compile\t\t\tGenerate .ipa file for device"
	echo "deploy\t\t\tInstall the .ipa file to the device connected in USB"
	echo "simulate\t\tGenerate an .ipa file for your simulator"
	echo "launch\t\t\tInstall and load the application in your simulator"
	echo "run\t\t\tCombine the commands simulate and launch"
}

if test ${command}
then         

	case "$command" in
		  "compile")
		TXT="making device version"
		_title ${TXT}
		echo "Please wait ... compiling..."
		echo $PWD/$FILENAME_PROD
		"$PATH_ADT" -package -target ipa-ad-hoc -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass 			 $PASSWORD $FILENAME_PROD $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf
		echo "done."
		;;        
		"deploy")             
		TXT="Deploy test version on device"
		_title ${TXT}
		echo "Please wait ... sending ..."        
		echo $PWD/$FILENAME_PROD          
		"$PATH_TRANSPORT" -v $FILENAME_PROD
		echo "done."  
		;;     
		"simulate")
		TXT="Compiling a simulation version"
		_title ${TXT}
		echo "please wait .... compiling ..."   
		echo $PWD/$FILENAME_TEST    
		"$PATH_ADT" -package -target ipa-test-interpreter-simulator -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass $PASSWORD $FILENAME_TEST $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf -platformsdk $PATH_SDK
		echo "done"
		;;          
		"launch")
		TXT="Install & load simulation" 
		_title ${TXT}
		echo "please wait ... installing ..." 
		echo $PWD/$FILENAME_TEST
		"$PATH_ADT" -installApp -platform ios -platformsdk $PATH_SDK -device ios-simulator -package $FILENAME_TEST
		echo "please wait ... loading ..."
		"$PATH_ADT" -launchApp -platform ios -platformsdk $PATH_SDK -device ios-simulator -appid $ID
		echo "done."
		;;
		"run")
		./swfunixbuilder.sh simulate
		./swfunixbuilder.sh launch
		;;
		"help")
		_help
		;;
	esac
	exit 1;

else       
	_help                                                          
	exit 1;
fi