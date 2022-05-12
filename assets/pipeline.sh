#!/bin/bash
echo "CI/CD Pipeline will now run."

#check if npm can be installed
echo "Running npm install"
if npm install ; then 
	echo "npm install successfull"
	
	#check if application can be compiled
	echo "Running npm run build"
	if npm run build ; then 
		echo "npm run build successfull"
		
		#push updates to GitHub and run the application
		echo "Changes will be commited to GitHub"
		cd ..
		git add .
		git commit -m "Commiting from CI/CD Pipeline"
		git push
		cd assests
		
		echo "Running npm run start"
		npm run start
	else 
		echo "ERROR: Failed to compile"
	fi
else 
	echo "ERROR: Failed to run npm install"
fi 



