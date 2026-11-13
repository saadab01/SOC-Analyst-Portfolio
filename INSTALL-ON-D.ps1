# Install/merge the GitHub-ready SOC portfolio into D:\SOC-Analyst-Portfolio.
# Safe by design: never deletes existing files, makes backups of conflicting files,
# and never executes git push or publishes private screenshots.
$ErrorActionPreference = 'Stop'
$zip = Join-Path $env:USERPROFILE 'Downloads\SOC-Analyst-Portfolio-GitHub-Ready.zip'
$root = 'D:\SOC-Analyst-Portfolio'
if (-not (Test-Path -LiteralPath 'D:\')) { throw 'Drive D: does not exist.' }
if (-not (Test-Path -LiteralPath $zip)) { throw "Portfolio ZIP not found: $zip" }
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$staging = Join-Path $env:TEMP "SOC-Portfolio-Import-$stamp"
$backupRoot = Join-Path $root ".local-backups\$stamp"
try {
    Expand-Archive -LiteralPath $zip -DestinationPath $staging -Force
    $source = Join-Path $staging 'SOC-Analyst-Portfolio'
    if (-not (Test-Path -LiteralPath (Join-Path $source 'README.md'))) {
        throw "Unexpected ZIP layout. Expected SOC-Analyst-Portfolio\README.md"
    }
    New-Item -ItemType Directory -Path $root -Force | Out-Null
    $copied = 0; $backedUp = 0
    Get-ChildItem -LiteralPath $source -File -Recurse | ForEach-Object {
        $rel = $_.FullName.Substring($source.Length).TrimStart('\')
        $dest = Join-Path $root $rel
        $destDir = Split-Path -Parent $dest
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        $isDifferent = $true
        if (Test-Path -LiteralPath $dest) {
            $isDifferent = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $dest -Algorithm SHA256).Hash
            if ($isDifferent) {
                $backup = Join-Path $backupRoot $rel
                New-Item -ItemType Directory -Path (Split-Path -Parent $backup) -Force | Out-Null
                Copy-Item -LiteralPath $dest -Destination $backup
                $script:backedUp++
            }
        }
        if ($isDifferent) {
            Copy-Item -LiteralPath $_.FullName -Destination $dest -Force
            $script:copied++
        }
    }
    foreach ($lab in @(
        'Lab-01-Windows-Login-Investigation',
        'Lab-02-Network-Traffic-Analysis',
        'Lab-03-SIEM-Investigation',
        'Lab-04-Sysmon-Detection',
        'Lab-05-Phishing-Analysis',
        'Lab-06-Incident-Response'
    )) {
        foreach ($sub in @('screenshots','evidence')) {
            New-Item -ItemType Directory -Path (Join-Path (Join-Path $root $lab) $sub) -Force | Out-Null
        }
    }
    Write-Host "Portfolio location: $root" -ForegroundColor Green
    Write-Host "Files added/updated: $copied"
    Write-Host "Existing files backed up: $backedUp"
    if ($backedUp -gt 0) { Write-Host "Backups are in: $backupRoot" }
    Write-Host 'Original screenshots and evidence were not deleted.' -ForegroundColor Green
    Write-Host 'GitHub publish NOT performed. Review redacted images before pushing.' -ForegroundColor Yellow
    Get-ChildItem -LiteralPath $root | Select-Object Name, Mode | Format-Table -AutoSize
} finally {
    if (Test-Path -LiteralPath $staging) { Remove-Item -LiteralPath $staging -Recurse -Force }
}
