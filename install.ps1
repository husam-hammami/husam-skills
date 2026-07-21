# Install these skills into Claude Code (~/.claude/skills).
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dest = Join-Path $env:USERPROFILE ".claude\skills"
New-Item -ItemType Directory -Force $dest | Out-Null
Get-ChildItem (Join-Path $root "skills") -Directory | ForEach-Object {
    $target = Join-Path $dest $_.Name
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    Copy-Item $_.FullName $target -Recurse
    Write-Host "  installed $($_.Name)"
}
Write-Host "Done -> $dest"
