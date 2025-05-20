# Source directory to back up
$SourceDir = "Path\to\source\directory"

# Ledger file path
$LedgerFile = "Path\to\ledger.txt"

# Function to list external storage devices
function Get-ExternalStorage {
    Get-Volume | Where-Object { $_.DriveType -eq 'Removable' -or $_.DriveType -eq 'Fixed' } | Select-Object DriveLetter, FileSystemLabel
}

# Function to create a data structure for files and folders with progress bar
function New-DataStructure {
    param([string]$Directory)

    $Items = Get-ChildItem -Path $Directory -Recurse
    $TotalItems = $Items.Count
    $Counter = 0

    Write-Host "Analyzing directory: $Directory"

    $Items | ForEach-Object {
        $Counter++
        $ProgressPercent = [math]::Round(($Counter / $TotalItems) * 100, 2)
        Write-Progress -Activity "Analyzing $Directory" -Status "Processing: $($_.Name)" -PercentComplete $ProgressPercent

        [PSCustomObject]@{
            Name         = $_.Name
            Path         = $_.FullName
            LastModified = $_.LastWriteTime
        }
    }
}

# Function to log ledger details
function Write-Ledger {
    param([int]$FilesChanged, [int]$FilesCreated, [int]$FilesDeleted, [string]$SizeCopied)
    $DateTime = Get-Date -Format "MM/dd/yyyy hh:mm:ss tt"
    Add-Content -Path $LedgerFile -Value @"
Backup Report
===============
Date and Time: $DateTime
Files Changed: $FilesChanged
Files Created: $FilesCreated
Files Deleted: $FilesDeleted
Size Copied: $SizeCopied
---------------
"@
}

# Step 1: Scan for external storage
Write-Host "Scanning for external storage devices..."
$Devices = Get-ExternalStorage

if ($Devices.Count -eq 0) {
    Write-Host "No external storage devices found."
    return
}

Write-Host "Found external storage devices:"
$Devices | ForEach-Object { Write-Host "$($_.DriveLetter): - $($_.FileSystemLabel)" }

# Select target device interactively
$TargetDrive = Read-Host "Enter the drive letter of the target device (e.g., D)"

# Ensure the target directory exists
$TargetDir = "${TargetDrive}:\BACKUP"

if (-not (Test-Path $TargetDir)) {
    Write-Host "Creating BACKUP directory on ${TargetDrive}..."
    New-Item -Path $TargetDir -ItemType Directory | Out-Null
}

# Step 2: Create data structure for the source directory
Write-Host "Analyzing source directory..."
$SourceData = New-DataStructure -Directory $SourceDir

# Step 3: Create or compare data structure for the target directory
Write-Host "Analyzing target directory..."
if (-not (Get-ChildItem -Path $TargetDir -Recurse -ErrorAction SilentlyContinue)) {
    Write-Host "Target directory is empty. Copying all files from source..."

    $Files = Get-ChildItem -Path $SourceDir -Recurse
    $TotalFiles = $Files.Count
    $Counter = 0

    foreach ($File in $Files) {
        $Counter++
        $ProgressPercent = [math]::Round(($Counter / $TotalFiles) * 100, 2)
        Write-Progress -Activity "Copying Files" -Status "Copying: $($File.FullName)" -PercentComplete $ProgressPercent
        Copy-Item -Path $File.FullName -Destination $TargetDir -Recurse -Force
    }

    Write-Ledger -FilesChanged 0 -FilesCreated $SourceData.Count -FilesDeleted 0 -SizeCopied ((Get-ChildItem -Path $SourceDir -Recurse | Measure-Object -Property Length -Sum).Sum | ForEach-Object { [math]::Round($_ / 1MB, 2) }) + " MB"
    Write-Host "Initial backup completed."
    return
}

$TargetData = New-DataStructure -Directory $TargetDir

# Step 4: Compare source and target, copy modified/new files
Write-Host "Comparing source and target..."
$FilesChanged = 0
$FilesCreated = 0
$FilesDeleted = 0
$TotalSizeCopied = 0

$TotalItems = $SourceData.Count
$Counter = 0
foreach ($SourceFile in $SourceData) {
    $Counter++
    $ProgressPercent = [math]::Round(($Counter / $TotalItems) * 100, 2)
    Write-Progress -Activity "Syncing Files" -Status "Processing: $($SourceFile.Path)" -PercentComplete $ProgressPercent

    $TargetFile = $TargetData | Where-Object { $_.Path -eq $SourceFile.Path.Replace($SourceDir, $TargetDir) }
    $TargetPath = $SourceFile.Path.Replace($SourceDir, $TargetDir)

    if (-not $TargetFile) {
        Copy-Item -Path $SourceFile.Path -Destination $TargetPath -Force
        $FilesCreated++
        $TotalSizeCopied += (Get-Item -Path $SourceFile.Path).Length
    } elseif ($SourceFile.LastModified -gt $TargetFile.LastModified) {
        Copy-Item -Path $SourceFile.Path -Destination $TargetPath -Force
        $FilesChanged++
        $TotalSizeCopied += (Get-Item -Path $SourceFile.Path).Length
    }
}

# Check for files that are in the target but not in the source
$TargetPaths = $TargetData.Path
$SourcePaths = $SourceData.Path.Replace($SourceDir, $TargetDir)

foreach ($TargetFile in $TargetPaths) {
    if (-not ($SourcePaths -contains $TargetFile)) {
        if (Test-Path -Path $TargetFile) {
            Remove-Item -Path $TargetFile -Force
            $FilesDeleted++
        } else {
            Write-Warning "File not found: $TargetFile. Skipping deletion."
        }
    }
}

# Convert size to MB
$FormattedSize = [math]::Round($TotalSizeCopied / 1MB, 2)

# Step 5: Write ledger
Write-Host "Writing backup details to ledger..."
if (-not (Test-Path $LedgerFile)) {
    Write-Host "No previous backup record found. Creating ledger..."
    Add-Content -Path $LedgerFile -Value "No previous backup record found."
}

Write-Ledger -FilesChanged $FilesChanged -FilesCreated $FilesCreated -FilesDeleted $FilesDeleted -SizeCopied "$FormattedSize MB"

Write-Host "Backup completed successfully."