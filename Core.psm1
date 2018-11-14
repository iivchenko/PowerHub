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

function open()
{
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet("vs", "paas", "paastest", "paasall", "psp", "kyc", "kyctest", "kycall","ppvapi", "ppvweb", "ppvtest", "ppvall", "done")]
        [string]$name
    )

    switch ($name)
    {
        'vs'
        {
            . "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
        }

        'paas'
        {
            . "$paas\Paas\Paas.sln"
        }

        'paastest'
        {            
            . "$paas\Betsson Payments Testing\Betsson.Payments.Testing.sln"
        }

        'paasall'
        {
            . "$paas\Paas\Paas.sln"
            . "$paas\Betsson Payments Testing\Betsson.Payments.Testing.sln"
        }

        'psp'
        {
            . "$psp\Psp\Psp.sln"
        }

        'kyc'
        {
            . "$kyc\KYCNow\KYCNow.sln"
        }

        'kyctest'
        {
            . "$kyc\KycNow Testing\KYCNow.Testing.sln"
        }

        'kycall'
        {
            . "$kyc\KYCNow\KYCNow.sln"
            . "$kyc\KycNow Testing\KYCNow.Testing.sln"
        }
                
        'ppvapi' 
        {
            . "$ppv\WebAPI\Payment.Web.sln"
        }
        
         
        'ppvweb'
        {
            . "$ppv\Web\PaymentPagesV.sln"
        }

          
        'ppvtest'
        {
            . "$ppv\Tests\PaymentPagesV.UITests.sln"
        }

        'ppvall'
        {
            . "$ppv\WebAPI\Payment.Web.sln"
            . "$ppv\Web\PaymentPagesV.sln"
            . "$ppv\Tests\PaymentPagesV.UITests.sln"
        }

        'done'
        {
            . "C:\_src\Shogun\done\Src\Done.sln"
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