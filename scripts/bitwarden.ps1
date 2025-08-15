#!/usr/bin/env powershell
# Bitwarden authentication script for Windows

$ErrorActionPreference = "Stop"

# Check if already logged in
$status = bw status --raw | ConvertFrom-Json
if ($status.status -eq "unlocked") {
    Write-Host "Already logged in and unlocked."
    exit 0
}

# Prompt for all credentials upfront
$email = $null
$plainPassword = $null
$twoFactorCode = $null

if ($status.status -ne "unlocked") {
    Write-Host "Please login to Bitwarden..."
    $email = Read-Host "Enter email"
    $password = Read-Host "Enter password" -AsSecureString
    $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
    
    # Assume 2FA is used
    $twoFactorCode = Read-Host "Enter two-factor authentication code"
}

try {
    if ($status.status -ne "unlocked") {
        # Login with credentials (handles both locked and unauthenticated states)
        $sessionKey = bw login $email $plainPassword --method 0 --code $twoFactorCode --raw
        
        if ($LASTEXITCODE -eq 0) {
            $env:BW_SESSION = $sessionKey
            $newStatus = bw status --raw | ConvertFrom-Json
            Write-Host "Login and unlock successful. Status: $($newStatus.status)"
        } else {
            throw "Login failed"
        }
    }
}
catch {
    Write-Error "Failed to authenticate: $_"
    exit 1
}
finally {
    # Clean up sensitive variables
    $email = $null
    $plainPassword = $null
    $twoFactorCode = $null
}

Write-Host "Bitwarden authentication complete."