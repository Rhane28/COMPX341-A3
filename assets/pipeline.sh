#!/bin/bash

#check a commit message has been passed in
[ -z "$1" ] && echo "Please enter a commit message." && exit

echo "CI/CD Pipeline will now run."

#check if npm can be installed
echo "Running npm install"
if npm install ; then 
	echo "npm install successfull"
	
	#check if the current commit will be the final maintenance change
	if [ "$2" == "final" ] ; then 
		echo "Commit associated with final maintenance change"
		echo "Finding all .ts files"
		find ../ -type f -name '*.ts' -exec sed -i '1s;^;//Rhane Mercado 1529860\n;' {} +
		echo "All .ts files have been found and commented"
	fi
	
	#check if application can be compiled
	echo "Running npm run build"
	if npm run build ; then 
		echo "npm run build successfull"
		
		#push updates to GitHub and run the application
		echo "Changes will be commited to GitHub"
		cd ..
		git add .
		git commit -m "$1"
		git push
		cd assets
		
		echo "Running npm run start"
		npm run start
	else 
		echo "ERROR: Failed to compile"
	fi
else 
	echo "ERROR: Failed to run npm install"
fi 



