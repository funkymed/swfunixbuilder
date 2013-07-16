#!/bin/sh
source config.sh
command=$1
     
function_help () { 
	echo "***************************************************************************"     
	echo "*                                 HELP                                    *"     
	echo "***************************************************************************"
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
		echo "***************************************************************************"     
		echo "*                        making device version                            *"     
		echo "***************************************************************************"
		echo "Please wait ... compiling..."
		echo $PWD/$FILENAME_PROD
		"$PATH_ADT" -package -target ipa-ad-hoc -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass 			 $PASSWORD $FILENAME_PROD $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf
		echo "done."
		;;        
		"deploy")             
		echo "***************************************************************************"    
		echo "*                     Deploy test version on device                       *"    
		echo "***************************************************************************"
		echo "Please wait ... sending ..."        
		echo $PWD/$FILENAME_PROD          
		"$PATH_TRANSPORT" -v $FILENAME_PROD
		echo "done."  
		;;     
		"simulate")
		echo "***************************************************************************"   
		echo "*                    Compiling a simulation version                       *"   
		echo "***************************************************************************"
		echo "please wait .... compiling ..."   
		echo $PWD/$FILENAME_TEST    
		"$PATH_ADT" -package -target ipa-test-interpreter-simulator -provisioning-profile $PATH_PROVISION -keystore $PATH_KEY -storetype PKCS12 -storepass $PASSWORD $FILENAME_TEST $FILENAME_MAIN-app.xml $FILENAME_MAIN.swf -platformsdk $PATH_SDK
		echo "done"
		;;          
		"launch")
		echo "***************************************************************************"        
		echo "*                       Install & load simulation                         *"        
		echo "***************************************************************************"
		echo "please wait ... installing ..." 
		echo $PWD/$FILENAME_TEST
		"$PATH_ADT" -installApp -platform ios -platformsdk $PATH_SDK -device ios-simulator -package $FILENAME_TEST
		echo "please wait ... loading ..."
		"$PATH_ADT" -launchApp -platform ios -platformsdk $PATH_SDK -device ios-simulator -appid $ID
		echo "done."
		;;
		"run")
		./simulate.sh
		./launch.sh
		;;
		"help")
		function_help
		;;
	esac


else       
	function_help                                                          
fi