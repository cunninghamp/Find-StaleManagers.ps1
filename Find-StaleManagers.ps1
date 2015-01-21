<#
.SYNOPSIS
Find-StaleManagers.ps1

.DESCRIPTION 
Sample script for locating stale manager entries on Exchange Server mailboxes.

.EXAMPLE
.\Find-StaleManagers.ps1

.LINK
https://exchangeserverpro.com

.NOTES
Written by: Paul Cunningham

For more Exchange Server tips, tricks and news
check out Exchange Server Pro.

* Website:	http://exchangeserverpro.com
* Twitter:	http://twitter.com/exchservpro

Find me on:

* My Blog:	http://paulcunningham.me
* Twitter:	https://twitter.com/paulcunningham
* LinkedIn:	http://au.linkedin.com/in/cunninghamp/
* Github:	https://github.com/cunninghamp

Change Log:
V1.00, 21/01/2015 - Initial version
#>

#Requires -Version 2

$recipients = @(Get-Recipient | Where {$_.Manager})

if ($recipients.count -eq 0)
{
    Write-Host "No recipients with managers found."
    EXIT
}

foreach ($recipient in $recipients)
{
    

	Write-Host -ForegroundColor White "*** Checking $($recipient.Identity.Name)"

    $manager = $recipient.Manager

    try
    {
        $getmanager = Get-Recipient $manager -ErrorAction STOP
        Write-Host -ForegroundColor Green "$($manager.Name) is okay"
    }
    catch
    {
        Write-Host -ForegroundColor Yellow "$($manager.Name) is stale"
    }
}


Write-Host -ForegroundColor White "*** Finished"