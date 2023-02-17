#Copyright (c)  mahdi delzendeh date 2023-02-17
#Script for build all prtoject in directory 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.



Function Build-Project{	
	param (
    [Parameter(ValueFromPipeline)]
	[ValidateNotNullOrEmpty()]
	# $targetDir: refer to directory where you want run this script
	[string]$targetDir,
	# $excludeRepos: refer to folder name where you will not check by script
    [string]$excludeRepos= "GitHub,Publisher2.1.6,Utravs-SSR",
	# $stopDir: the folder name where you stop go in deeps of directory: here is .git folder
    [string]$stopDir= ".git",
	#find solution name
	[string]$CompileProj1= ".sln"
	
	)
 
 if ($targetDir){
	 cd $targetDir; 	
	 Write-Host("**************************Directory Name: '" + $targetDir + "' *******************************")  -ForegroundColor Yellow -BackgroundColor DarkGreen;
	 $subDir = $(Get-ChildItem "$targetDir"  -directory);
	 
	 foreach($sub in $subDir) {
		 
		    if($excludeRepos.Contains($sub.Name)){
				Write-Host("--------------Skip Folder: '" + $sub.Name + "'---------------")  -ForegroundColor gray;
              continue;
            }
	
		    $childSubDir = $(Get-ChildItem "$sub" –force -directory);
			if(-Not $childSubDir.Name.Contains($stopDir) ){
				
				 $sub.FullName | Build-Project;
			}
			else{
				
				Write-Host("--------------Folder Name: '" + $sub.FullName + "'---------------")  -ForegroundColor green ;
				 
				$FileSubDir=$(Get-ChildItem "$sub" –force);
				cd $sub.FullName;
				$FileSubDir|Foreach-Object{
	               if($_.Name.Contains($CompileProj1) ){
					     $_.Name |DotNetBuild;								 
					 
				    }				
				  
                }
				
			}
			cd $targetDir; 	
	    }	 
    }
	
}
Function DotNetBuild{
	param (
    [Parameter(ValueFromPipeline)]
	[ValidateNotNullOrEmpty()]
	# $targetProject: refer to project solution name where you want build 
	[string]$targetProject
	)
	Write-Host("building Project: '" + $targetProject + "' ......")  -ForegroundColor black -BackgroundColor Yellow;
	
	$command=$("build --verbosity q "+$targetProject);
	$p=Start-Process -FilePath 'dotnet'   -Wait -NoNewWindow  -ArgumentList $command;
	
}
Function Print-Logo{
Write-Host(".&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&.");
Write-Host(".&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&.");
Write-Host(".&@@@J7J@@@@@&?7Y@P7777??7777P@57?777?YG@@@@@@@Y777G@@@@B77Y@@@@@@G77G@&5?!~!75@@@&.");
Write-Host(".&@@&. .&@@@@B  ^@G??J^  ~J??G@^  ?YJ!  ~&@@@@5    :#@@@&^  P@@@@&: :&#: .Y5Y7!&@@&.");
Write-Host(".&@@&: :&@@@@B  ^@@@@@Y  Y@@@@@~  B@@#.  #@@@B. ?G  ~@@@@B. :&@@@7  G@G  :P#@@@@@@&.");
Write-Host(".&@@&: :&@@@@B  ^@@@@@J  J@@@@@~  ^~~..!G@@@&^ ~@@Y  J@@@@5  7@@5  Y@@@P~.  :!P@@@&.");
Write-Host(".&@@&. .&@@@@B  ^@@@@@J  J@@@@@~  JP7  7@@@@7  ~??7   P@@@@7  5&. !@@@@@@&GY^  7@@&.");
Write-Host(".&@@@@Y~..::.:!P@@@@@@Y..Y@@@@@!..B@@@J. ?#:.!@@@@@@5. !@@@@B:..:G@@@@5::::..^J&@@&.");  
Write-Host(".&@@@@@@&#B##&@@@@@@@@@&&@@@@@@&#&@@@@@&#&@#&@@@@@@@@&#&@@@@@&&&&@@@@@@@&#B#&@@@@@&.");     
Write-Host(".&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&.");        
Write-Host(".&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&."); 
Write-Host(".&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&."); 
Write-Host(".&@@@@@@@@@@@@@@@@@@@@@@         https://utravs.com                 @@@@@@@@@@@@@@&.");
Write-Host(".&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&."); 
	
}
Print-Logo;
"D:\\Projects" | Build-Project; 
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
