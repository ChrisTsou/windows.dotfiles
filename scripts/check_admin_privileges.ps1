# Check if the user account is member of Administrators group (regardless of UAC)
# Exit code 0 = user has admin privileges, Exit code 1 = user does not have admin privileges
try {
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $adminGroup = Get-LocalGroupMember -Group "Administrators" | Where-Object { $_.Name -eq $currentUser -or $_.Name -eq ($currentUser -split '\\')[-1] }
    
    if ($adminGroup) {
        exit 0
    } else {
        exit 1
    }
} catch {
    # Fallback method using net localgroup
    $userName = $env:USERNAME
    $adminMembers = net localgroup administrators | Select-String $userName
    
    if ($adminMembers) {
        exit 0
    } else {
        exit 1
    }
}