#Copyright (c)  "Mahdi Delzendeh"  date 2022-12-18
#Script for Update Fork From Upstream 
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


# $targetDir: refer to directory where you want run this script
# $excludeRepos: refer to folder name where you will not check by script
# $stopDir: the folder name where you stop go in deeps of directory: here is .git folder
# $canUpdateAllBranches: the condition which define git command run on all branches or not

param (
    [Parameter][string]$targetDir,
    [string]$excludeRepos= "notallowedFolder,",
    [string]$stopDir= ".git",
    [bool]$canUpdateAllBranches= 0
	
 )

$currentDir = Get-Location;
    Write-Host("**************************Folder Name: '" + $currentDir + "' *******************************")  -ForegroundColor Yellow -BackgroundColor DarkGreen;

$subDir = $(Get-ChildItem "$currentDir"  -directory);
if (!$targetDir) { 
	$subDir = $(Get-ChildItem "$targetDir"  -directory);
}


foreach($sub in $subDir) {
    
    if($excludeRepos.Contains($sub.Name)){
        continue;
    }

    Write-Host("**************************Folder Name: '" + $sub.Name + "' *******************************")  -ForegroundColor Yellow -BackgroundColor DarkGreen;
	
	$childSubDir = $(Get-ChildItem "$sub" –force -directory);
	
	if(-Not $childSubDir.Name.Contains($stopDir) ){
		 
		 foreach($childSub in $childSubDir){
			 
			  Write-Host("------------------------Repository Name '" + $childSub.Name + "' -----------------------------") -ForegroundColor Green;
			  
			 cd $childSub.FullName;
			 $curBranch = $(git branch --show-current);
			 $curBranch = $curBranch.Trim();
		     Write-Host("..........................updating current branch '" + $curBranch + "' ..........................") -ForegroundColor Red;
			 git pull upstream $curBranch;
			 if($canUpdateAllBranches){
				 $branches = $(git branch);
			 foreach($branch in $branches) {

				$branch = $branch.Replace("* ","");
				$branch = $branch.Trim();

				if($curBranch.CompareTo($branch) -ne 0){
            
					Write-Host("..........................updating branch '" + $branch + "' ..........................") -ForegroundColor Red;

					git checkout "$branch" -q;
            
					git pull upstream $branch;

					Write-Host("");
				}
			}
			 git checkout "$curBranch" -q;
			 }
			 
		 }
		
	}
	else{
		 Write-Host("------------------------Repository Name '" + $sub.Name + "' -----------------------------") -ForegroundColor Green;
		 
		 cd $sub.FullName;
		 $curBranch = $(git branch --show-current);
	     $curBranch = $curBranch.Trim();
		 Write-Host("------------------------updating current branch '" + $curBranch + "' -----------------------------") -ForegroundColor Green;
	     git pull upstream $curBranch;
		 if($canUpdateAllBranches) {
		  $branches = $(git branch);
		  foreach($branch in $branches) {

				$branch = $branch.Replace("* ","");
				$branch = $branch.Trim();

				if($curBranch.CompareTo($branch) -ne 0){
            
					Write-Host("-------------------------updating branch '" + $branch + "' ------------------------------") -ForegroundColor Yellow;

					git checkout "$branch" -q;
            
					git pull upstream $branch;

					Write-Host("");
				}
			}
	     git checkout "$curBranch" -q;
		 }

	}
   cd $currentDir;     
}

cd $currentDir;
    
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
