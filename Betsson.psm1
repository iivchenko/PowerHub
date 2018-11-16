### Helpers ###
#sql "sp_databases" - get databases
#sql -Database <name> "select * from sys.tables" - get tables

#### Variables ###

Set-Variable -Name bets   -Value "C:\_src\Betssons"
Set-Variable -Name paas   -Value "$bets\Payment - PAAS\paas"Set-Variable -Name psp    -Value "$bets\Payment - PSP\psp"Set-Variable -Name ppv    -Value "$bets\Payment - Payment Pages\ppv"
Set-Variable -Name kyc    -Value "$bets\Payment - KYC\kycnow"
Set-Variable -Name bc     -Value "$bets\Payment - Branded Cards\branded-cards"

Set-Variable -Name MyHome -Value $bets

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
        [ValidateSet("bc", "paas", "psp", "bets","kyc","ppv")]
        [string]$name
    )

    switch ($name)
    {
        'bc'
        {
            cd $bc
        }
        'bets'
        {
            cd $bets
        }

        'paas'
        {
            cd $paas
        }

        'psp'
        {
            cd $psp
        }

        'kyc' 
        {
            cd $kyc
        }

        
        'ppv' 
        {
            cd $ppv
        }        
    }
}

function open()
{
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet("vs", "bcweb", "bcapi", "bctest", "bcall", "paas", "paastest", "paasall", "psp", "kyc", "kyctest", "kycall","ppvapi", "ppvweb", "ppvtest", "ppvall", "done")]
        [string]$name
    )

    switch ($name)
    {
        'vs'
        {
            . "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
        }
        
        'bcweb'
        {
            . "$bc\BrandedCards.AdminWeb\BrandedCards.AdminWeb.sln"
        }

        'bcapi'
        {
            . "$bc\BrandedCards.API\BrandedCards.sln"
        }

        'bctest'
        {
            . "$bc\BrandedCards.Testing\BrandedCards.Testing.sln"
        }

        'bcall'
        {
            . "$bc\BrandedCards.AdminWeb\BrandedCards.AdminWeb.sln"
            . "$bc\BrandedCards.API\BrandedCards.sln"
            . "$bc\BrandedCards.Testing\BrandedCards.Testing.sln"
            . "$bc\BrandedCards.Testing.Fakes\BrandedCards.Testing.Fakes.sln"
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

function game()
{
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet("guess", "snake")]
        [string]$name
    )



    switch ($name)
    {
        'guess'
        {
            . "dotnet" "run" "--project" "C:\_src\Shogun\Learning-FSharp\LearningFSharp.Games.GuessNumber\LearningFSharp.Games.GuessNumber.fsproj"
        }
		
		 'snake'
        {
            . "dotnet" "run" "--project" "C:\_src\Shogun\Learning-FSharp\LearningFSharp.Games.Snake\LearningFSharp.Games.Snake.fsproj"
        }
    }

}


#### Setup ###
Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'
Set-Location $MyHome
New-Alias sql Invoke-Sqlcmd