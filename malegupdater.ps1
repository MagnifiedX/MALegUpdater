#requires -version 2
<#
.SYNOPSIS
  Mass Legislature Bill Monitoring Tool

.DESCRIPTION
  MALegUpdater.ps1 is a tool to check the Mass legislature for updates to the site. This is done by hashing the relevant section of the loaded page, and comparing it to the last retrieved copy.
  Any changes found will save a new copy of the document to the last updated file, as well as a copy in the archive, and pulse out a Webhook request to the configured Discord server and the associated channel.

.PARAMETER BillNumber
  The number of the bill, starting with HD or SD, to be checked.

.PARAMETER SessionNumber
  The current General Court of the Commonwealth of Massachusetts (Default: "193" which is the current legislative session for 2023-2024)

.INPUTS
  The State Senate or House Bill Number, formatted like HD#### or SD####
  The Number of the General Court of the Commonwealth of Masschusetts the bill was filed under (Default: "193")

.OUTPUTS
  TBD

.NOTES
  Version:        0.01
  Author:         Adam Cyr
  Creation Date:  12/29/2023
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "Stop"

#Dot Source required Function Libraries
#. "C:\Scripts\Functions\Logging_Functions.ps1"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = "0.01"

#Log File Info
$sLogPath = "C:\temp"
$sLogName = "malegupdater-$(Get-Date -Format FileDateTimeUniversal).log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------



function MALegUpdater {
  param(
      # Sets default session number to the 2023-2024 legislative session
      [int]$SessionNumber = 193,
      
      # Sets the bill number parameter
      [string]$BillNumber
  )
  
  begin{
    # Validates the input parameters, and prompts if not provided
    $SessionNumberTemp = Read-Host -Prompt "Please specify the legislative session (Default: 193) you wish to query."
    Log-Write -LogPath $sLogFile -LineValue "SessionNumberTemp Value entered: $SessionNumberTemp"
      
    if ($SessionNumberTemp -ne 193 ) {
      Write-Host "Using session # $SessionNumberTemp."
    }
      
    else {
       $SessionNumberTemp = $null
       Write-Host "Using default session # 193."
    }

    $BillNumberTemp = Read-Host "Please specify the bill you wish to query (Format: HD#### or SD####)"
    Log-Write -LogPath $sLogFile -LineValue "BillNumberTemp Value Entered: $BillNumberTemp"
  }
  
  process{
    try{
      # Validating inputs
      # TBD, for now just assigning the inputs to their main variables
      if ($SessionNumberTemp -not $null) {
        $SessionNumber = $SessioNumberTemp
      }
      elseif ($SessionNumberTemp -is $null) {
        $SessionNumber = 193
      }
      else {
        throw $SessionNumberTemp
      }
      $webRequest = Invoke-WebRequest -Uri "https://malegislature.gov/Bills/$SessionNumber/$BillNumber/BillHistory"
    }
    
    catch{
      Log-Error -LogPath $sLogFile -ErrorDesc $_.Exception -ExitGracefully $True
      break
    }
  }
  
  end{
    if($?){
      Log-Write -LogPath $sLogFile -LineValue "Completed Successfully."
      Log-Write -LogPath $sLogFile -LineValue " "
    }
  }
}



#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Log-Start -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion
#Script Execution goes here
#Log-Finish -LogPath $sLogFile