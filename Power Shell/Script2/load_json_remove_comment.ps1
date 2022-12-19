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


$jsonFile=(Get-Content "my.json" -raw ) ;

#remove /*your comment */  format
$jsonFile=$jsonFile -replace  '(?ms)/\*.*?\*/';

# remove //your comment  format
$jsonFile=$jsonFile -replace  '(?m)\s*//.*?$';

$jsonFile| ConvertFrom-Json ;
 
Write-Host $jsonFile;   
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
