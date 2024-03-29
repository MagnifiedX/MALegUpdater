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
$ErrorActionPreference = "SilentlyContinue"

#Dot Source required Function Libraries
. "C:\Scripts\Functions\Logging_Functions.ps1"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = "1.0"

#Log File Info
$sLogPath = "C:\Windows\Temp"
$sLogName = "<script_name>.log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#

Function <FunctionName>{
  Param()
  
  Begin{
    Log-Write -LogPath $sLogFile -LineValue "<description of what is going on>..."
  }
  
  Process{
    Try{
      <code goes here>
    }
    
    Catch{
      Log-Error -LogPath $sLogFile -ErrorDesc $_.Exception -ExitGracefully $True
      Break
    }
  }
  
  End{
    If($?){
      Log-Write -LogPath $sLogFile -LineValue "Completed Successfully."
      Log-Write -LogPath $sLogFile -LineValue " "
    }
  }
}

#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Log-Start -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion
#Script Execution goes here
#Log-Finish -LogPath $sLogFile