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
} else {
    Write-Host "Bitwarden CLI is already installed."
}

Write-Host "Bitwarden CLI installation complete."