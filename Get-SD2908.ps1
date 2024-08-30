# Get-SD2908.ps1

$SubsequentRun = Test-Path -Path "report1.html"

if ($SubsequentRun -eq $false) {
    Write-Host "First run detected. Fetching the BillHistory page, and then shutting down."
    Invoke-WebRequest -Uri "https://malegislature.gov/Bills/193/SD2908/BillHistory" | Out-File -FilePath "report1.html"
}
else {
    Write-Host "Fetching latest copy of SD2908 bill history, and comparing it with the last version fetched."
    Invoke-WebRequest -Uri "https://malegislature.gov/Bills/193/SD2908/BillHistory" | Out-File -FilePath "report2.html"
    $checkPage = Compare-Object (Get-Content "report1.html") (Get-Content "report2.html")
    if ($null -eq $checkPage) {
        Write-Host "No changes detected, exiting."
    }
    else {
        Write-Host "Change detected, issuing Discord webhook request."
    }
}