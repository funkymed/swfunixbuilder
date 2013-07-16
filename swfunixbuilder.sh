#!/bin/sh
source config.sh
command=$1
                                              
_title()
{      
	if test $1
	then
		echo "***************************************************************************"     
		echo "*\t\t"$*
		echo "***************************************************************************"
	fi                   
}

_help () { 
	TXT="Help"
	_title ${TXT}  
	echo "COMMANDS :"    
	echo "help\t\t\tHelp"
	echo "credit\t\t\tCredit"  
	echo "compile\t\t\tGenerate .ipa file for device with optimised code (slower)"
	echo "fastcompile\t\tGenerate .ipa for device without optimised code"
	echo "deploy\t\t\tInstall the .ipa file to the device connected in USB"
	echo "simulate\t\tGenerate an .ipa file for your simulator"
	echo "launch\t\t\tInstall and load the application in your simulator"
	echo "run\t\t\tCombine the commands simulate and launch"
}

if test ${command}
then         

	case "$command" in
		  "compile")
			TXT="Generate .ipa file in ipa-ad-hoc (slow)"
			_title ${TXT}
			echo "Please wait ... compiling..."
			echo $PWD/$FILENAME_PROD
			"$PATH_ADT" -package -target ipa-ad-hoc -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass $PASSWORD $FILENAME_PROD $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf
			echo "done."    
			exit 1;          
		;;
		  "fastcompile")
			TXT="Generate .ipa file in ipa-test-interpreter (fast)"
			_title ${TXT}
			echo "Please wait ... compiling..."
			echo $PWD/$FILENAME_PROD
			"$PATH_ADT" -package -target ipa-test-interpreter -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass $PASSWORD $FILENAME_PROD $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf
			echo "done."    
		exit 1; 
		;;        
		"deploy")             
			TXT="Deploy test version on device"
			_title ${TXT}
			echo "Please wait ... sending ..."        
			echo $PWD/$FILENAME_PROD          
			"$PATH_TRANSPORT" -v $FILENAME_PROD
			echo "done."
			exit 1;       
		;;     
		"simulate")
			TXT="Generate .ipa for simulator"
			_title ${TXT}
			echo "please wait .... compiling ..."   
			echo $PWD/$FILENAME_TEST    
			"$PATH_ADT" -package -target ipa-test-interpreter-simulator -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass $PASSWORD $FILENAME_TEST $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf -platformsdk $PATH_SDK
			echo "done" 
			exit 1;     
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
			exit 1;     
		;;
		"run")
			./swfunixbuilder.sh simulate
			./swfunixbuilder.sh launch
		;;
		"help")
			_help
			exit 1;     
		;;          
		"credit")
			echo "Swf unix builder (2013-07)"
			echo "Shell code by Cyril Pereira, Ruby by Igor Sokolov"
			exit 1;     
		;;
	esac
	_help                                                          
	exit 1;

else       
	_help                                                          
	exit 1;
fi