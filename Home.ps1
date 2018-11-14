#### Variables ###

Set-Variable -Name source -Value $HOME\Source

#### Functions ###

function guid()
{
    [System.Guid]::NewGuid().ToString()
}

function here()
{
    & "explorer.exe" .
}

function go()
{
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet("source")]
        [string]$name
    )

    switch ($name)
    {
        'source'
        {
            cd $source
        }
    }
}

function edit()
{
    param
    (
        [string]$path
    )

    & "C:\Program Files\Notepad++\notepad++.exe" $path
}

function toUnits()
{
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [double]$value
    )

    $units =  "byte", "kB", "mb", "gb", "tb"

    foreach ($unit in $units)
    {
        if ($value -gt 1023)
        {
            $value = $value / 1024
        }
        else
        {
            $result = [math]::Round($value,2)
            return "$result $unit"
        }
    }
}

# TODO: This could be moved to my PowerEnv Project
# TODO: Add beautification for size
function idir()
{
    param
    (
        [switch]$File
    )

    $location = (Get-Location).Path

    dir | select -Property @{Name="Type"; Expression = {if ($_.GetType() -eq [System.IO.DirectoryInfo]){"DIR"}else{"FILE"}}}, Name, @{Label="Size"; Expression = {if ($_.GetType() -eq [System.IO.FileInfo]) {toUnits -value $_.Length}else{"<DIR>"}}}
}


#### Setup ###
#Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'
Set-Location $HOME