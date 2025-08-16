#!/usr/bin/env pwsh
# Bitwarden CLI installation script for Windows

$ErrorActionPreference = "Stop"

Write-Host "Checking Bitwarden CLI installation..."

# Check if bw is installed
if (-not (Get-Command bw -ErrorAction SilentlyContinue)) {
    Write-Host "Bitwarden CLI not found. Installing with winget..."
    try {
        winget install --id Bitwarden.CLI --accept-package-agreements --accept-source-agreements
        Write-Host "Bitwarden CLI installed successfully."
    }
    catch {
        Write-Error "Failed to install Bitwarden CLI: $_"
        exit 1
    }
    
    # Refresh PATH to pick up new installation
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
}
else {
    Write-Host "Bitwarden CLI is already installed."
}

bw login --check

if (!$?) {
    $session = bw login --raw
        
    # Add new credential
    cmdkey /generic:"Bitwarden_Session_Token" /user:"BitwardenSession" /pass:"$session" | Out-Null
        
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to store session token in Credential Manager, but login was successful."
    }
}

# Retrieve session token and set environment variable
try {
    $credential = cmdkey /list | Where-Object { $_ -match "Bitwarden_Session_Token" }
    if ($credential) {
        $env:BW_SESSION = $session
    }
} catch {
    Write-Warning "Could not retrieve session token from Credential Manager"
}

Write-Host ""
Write-Host "Bitwarden session established." -ForegroundColor Green