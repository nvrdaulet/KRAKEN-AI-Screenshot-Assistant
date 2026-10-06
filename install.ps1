$ErrorActionPreference = "Stop"

$TaskName = "Kraken Background"

# ---------------------------------------------------------
# Project paths
# ---------------------------------------------------------

$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$WatcherPath = Join-Path $ProjectDir "watcher.py"
$EnvPath = Join-Path $ProjectDir ".env"
$RequirementsPath = Join-Path $ProjectDir "requirements.txt"

Write-Host ""
Write-Host "====================================="
Write-Host "       KRAKEN INSTALLER"
Write-Host "====================================="
Write-Host ""


# ---------------------------------------------------------
# Verify required files
# ---------------------------------------------------------

if (-not (Test-Path $WatcherPath)) {
    Write-Host "[ERROR] watcher.py was not found."
    exit 1
}

if (-not (Test-Path $EnvPath)) {
    Write-Host "[ERROR] .env was not found."
    Write-Host ""
    Write-Host "Copy .env.example to .env and add your own credentials."
    exit 1
}

if (-not (Test-Path $RequirementsPath)) {
    Write-Host "[ERROR] requirements.txt was not found."
    exit 1
}


# ---------------------------------------------------------
# Find Python
# ---------------------------------------------------------

try {
    $PythonExe = (& py -c "import sys; print(sys.executable)").Trim()
}
catch {
    Write-Host "[ERROR] Python was not found."
    Write-Host "Install Python first and make sure the 'py' command works."
    exit 1
}

if (-not (Test-Path $PythonExe)) {
    Write-Host "[ERROR] Python executable was not found."
    exit 1
}

$PythonDir = Split-Path $PythonExe
$PythonwExe = Join-Path $PythonDir "pythonw.exe"

if (-not (Test-Path $PythonwExe)) {
    Write-Host "[ERROR] pythonw.exe was not found."
    exit 1
}

Write-Host "[OK] Python found:"
Write-Host $PythonExe
Write-Host ""


# ---------------------------------------------------------
# Install Python dependencies
# ---------------------------------------------------------

Write-Host "Installing Python dependencies..."

& py -m pip install -r $RequirementsPath

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to install dependencies."
    exit 1
}

Write-Host "[OK] Dependencies installed."
Write-Host ""


# ---------------------------------------------------------
# Remove old Kraken task if it exists
# ---------------------------------------------------------

$ExistingTask = Get-ScheduledTask `
    -TaskName $TaskName `
    -ErrorAction SilentlyContinue

if ($ExistingTask) {

    Write-Host "Removing existing Kraken task..."

    Stop-ScheduledTask `
        -TaskName $TaskName `
        -ErrorAction SilentlyContinue

    Unregister-ScheduledTask `
        -TaskName $TaskName `
        -Confirm:$false
}


# ---------------------------------------------------------
# Create background task
# ---------------------------------------------------------

$Action = New-ScheduledTaskAction `
    -Execute $PythonwExe `
    -Argument "`"$WatcherPath`"" `
    -WorkingDirectory $ProjectDir


$Trigger = New-ScheduledTaskTrigger `
    -AtLogOn `
    -User $env:USERNAME


# Least privilege:
# Kraken does NOT require Administrator permissions.
$Principal = New-ScheduledTaskPrincipal `
    -UserId "$env:USERDOMAIN\$env:USERNAME" `
    -LogonType Interactive `
    -RunLevel Limited


$Settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -RestartCount 3 `
    -RestartInterval (New-TimeSpan -Minutes 1) `
    -ExecutionTimeLimit ([TimeSpan]::Zero) `
    -MultipleInstances IgnoreNew


Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $Action `
    -Trigger $Trigger `
    -Principal $Principal `
    -Settings $Settings `
    -Description "Kraken screenshot AI assistant background process." `
    -Force | Out-Null


Write-Host "[OK] Background task created."


# ---------------------------------------------------------
# Start Kraken now
# ---------------------------------------------------------

Start-ScheduledTask -TaskName $TaskName

Write-Host "[OK] Kraken background process started."
Write-Host ""
Write-Host "====================================="
Write-Host "Installation completed."
Write-Host ""
Write-Host "Hotkey: CTRL + ALT + K"
Write-Host "Initial state: OFF"
Write-Host "====================================="
Write-Host ""