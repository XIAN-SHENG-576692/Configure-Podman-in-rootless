$TargetDirectory = "$env:APPDATA\Code\User"
$TargetFile = "$TargetDirectory\settings.json"

# Create directory if it does not exist
if (-not (Test-Path -Path $TargetDirectory)) {
    New-Item -ItemType Directory -Path $TargetDirectory | Out-Null
}

# Load or initialize JSON object
if (Test-Path -Path $TargetFile) {
    try {
        $JsonData = Get-Content -Raw -Path $TargetFile | ConvertFrom-Json
    } catch {
        # If file is empty or corrupted, start with an empty object
        $JsonData = @{}
    }
} else {
    $JsonData = @{}
}

# If the data is parsed as a PSCustomObject, convert to a hash table to ensure easy modification
if ($JsonData -is [pscustomobject]) {
    $HashData = @{}
    foreach ($property in $JsonData.psobject.Properties) {
        $HashData[$property.Name] = $property.Value
    }
    $JsonData = $HashData
}

# Update or add the specific setting
$JsonData["dev.containers.dockerPath"] = "podman"

# Save back to settings.json
$JsonData | ConvertTo-Json -Depth 100 | Set-Content -Path $TargetFile

Write-Output "Successfully updated VS Code settings on Windows."