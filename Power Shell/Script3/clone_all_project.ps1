#Copyright (c)  "Mahdi Delzendeh"  date 2022-12-18
#Script for Git clone  All project from Json file
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.


Function Git-Clone-Project{
[CmdletBinding()]
Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object] 
        $Object
    )
	
foreach ($record in $Object)
 {
    Write-Host("************Folder Name: '" + $record.Directory + "' *******************")  -ForegroundColor Yellow -BackgroundColor DarkGreen;
	if (Test-Path $record.Directory) {
   
		Write-Host ("Folder $($record.Directory) Exists...") -ForegroundColor Red;    
	}
	else
	{     
	    $newfolder=	New-Item $record.Directory -ItemType Directory;
		Write-Host ( "Folder $($record.Directory) Created successfully...")-ForegroundColor Green;
	}
	cd $record.Directory;
    foreach ($project in $record.Projects){
		Write-Host("--------------- clone Repository  '" + $project.FolderName + "' -------------") -ForegroundColor Green;
		 git clone $project.Address $project.FolderName;
		
	}
     
  $record.SubDirectory | Git-Clone-Project;
 }	
}


$jsonFile=(Get-Content "Project.json" -raw ) ;
$jsonFile=$jsonFile -replace  '(?ms)/\*.*?\*/';
$jsonFile| ConvertFrom-Json |Git-Clone-Project;
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');