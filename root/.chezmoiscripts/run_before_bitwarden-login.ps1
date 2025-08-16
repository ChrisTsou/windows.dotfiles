bw login --check

if (!$?) {
    $session = bw login --raw
    if ($session) {
        # Set environment variable for current session
        $env:BW_SESSION = $session
        
        # Persist environment variable for user
        [System.Environment]::SetEnvironmentVariable("BW_SESSION", $session, "User")
    }
} else {
    # If already logged in, ensure BW_SESSION is available
    if (-not $env:BW_SESSION) {
        $env:BW_SESSION = [System.Environment]::GetEnvironmentVariable("BW_SESSION", "User")
    }
}

Write-Host "Bitwarden session established." -ForegroundColor Green

bw sync