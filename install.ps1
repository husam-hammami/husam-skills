# Install these skills AND their subagent definitions into Claude Code.
# The agents/ half is not optional: bulletproof spawns plan-reviewer, and warcry
# spawns warcry-scout / warcry-judge / warcry-premortem. Without them those skills break.
$ErrorActionPreference = "Stop"
$root   = Split-Path -Parent $MyInvocation.MyCommand.Path
$skills = Join-Path $env:USERPROFILE ".claude\skills"
$agents = Join-Path $env:USERPROFILE ".claude\agents"
New-Item -ItemType Directory -Force $skills | Out-Null
New-Item -ItemType Directory -Force $agents | Out-Null
Get-ChildItem (Join-Path $root "skills") -Directory | ForEach-Object {
    $target = Join-Path $skills $_.Name
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    Copy-Item $_.FullName $target -Recurse
    Write-Host "  skill  $($_.Name)"
}
Get-ChildItem (Join-Path $root "agents") -Filter *.md | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $agents $_.Name) -Force
    Write-Host "  agent  $($_.BaseName)"
}
Write-Host "Skills -> $skills"
Write-Host "Agents -> $agents"
