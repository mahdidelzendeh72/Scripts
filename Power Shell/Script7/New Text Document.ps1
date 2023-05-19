#Copyright (c)  mahdi delzendeh date 2023-05-19
#Script for Search in Root by spacial Pattern 
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
function Search-By-Pattern {
    [CmdletBinding()]
    param(
	# $Path : refer to directory where you want run this script
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Path,
		# $Pattern: refer tosearch pattern like "*.txt" , "*test*.pdf"
        [Parameter(Position = 1, Mandatory = $true)]
        [string]$Pattern
    )
    
    Get-ChildItem -Path $Path -Recurse -File | Where-Object { $_.Name -like $Pattern }| ForEach-Object {
    
       Write-Output $_.FullName
	}
}
# example of use
Search-By-Pattern -Path 'C:\Users' -Pattern '*.pdf';
pause;