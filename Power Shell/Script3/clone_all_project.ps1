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
        [object]$Object

    )
	
foreach ($record in $Object)
 {
    Write-Host("************Folder Name: '" + $record.Directory + "' *******************")  -ForegroundColor Yellow -BackgroundColor DarkGreen;
	if (Test-Path $record.Directory) {
   
		Write-Host ("Folder $($record.Directory) Exists...") -ForegroundColor Gray;    
	}
	else
	{     
	    $newfolder=	New-Item $record.Directory -ItemType Directory;
		Write-Host ( "Folder $($record.Directory) Created successfully...")-ForegroundColor Gray;
	}
	cd $record.Directory;
    foreach ($project in $record.Projects){
		Write-Host("--------------- clone Repository  '" + $project.FolderName + "' -------------") -ForegroundColor Green;
		 git clone $project.Address $project.FolderName; 		
	}
     
  $record.SubDirectory | Git-Clone-Project;
 }	
 
}
Function Print-Logo{
Write-Host ( "J@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");  
Write-Host ( "J@@@@@@@@@@@@@@@@#BB#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");  
Write-Host ( "J@@@@@@@@@@@@@@@#.  ^@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@@@#PJ??JYG@@@@@@@GY??JG#YYY5@@@@@B5J??J5B@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@&!        :P@@@&~      .   ^@@@B~        ^G@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@7   ?BBP.   #@@?   7B#B7   ^@@@~   JBBY   :&@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@^   #@@@!   G@@^   B@@@#   ^@@&.  :@@@@:  .#@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@^   #@@@~   G@@^   B@@@#   ^@@&.  :&@@@:  .#@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@^   #@@@~   G@@^   B@@@#   ^@@&.  :&@@@:  .#@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  :@@@@@@@@@@^   #@@@!   G@@^   B@@@#   ^@@&.  :&@@@:  .#@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  ^@@@@@@@@@@~   G@@@~   G@@~   G@@@G   ^@@&:  .#@@&:  .#@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#.  .!!!!!!!!#@P   :7?~   ~@@@5   :JY?.   ^@@@J   ^??^   ?@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@#:...........B@@G!:    .^Y&@@@@P~.   :!   ^@@@@P!:    .~5@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@@&&&&&&&&&&&&@@@@@&#BB#&@@@@@@BGP5GB#@#   ^@@@@@@&#BB#&@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@?   ?@@@Y   !@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#~   .:.   ~#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "J@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@GJ7~~!7JG@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "Y@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y");     
Write-Host ( "Y@@@@@@@@@@@@@@@@@@@@@   https://www.text-image.com/      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y"); 
Write-Host ( "Y@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y"); 
	
}

Print-Logo;
$jsonFile=(Get-Content "Easy-Microservice.json" -raw ) ;
$jsonFile=$jsonFile -replace  '(?ms)/\*.*?\*/';
$jsonFile| ConvertFrom-Json |Git-Clone-Project;
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');