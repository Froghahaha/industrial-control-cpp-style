param(
    [string]$CodexSkillsRoot = $(Join-Path $env:USERPROFILE '.codex\skills')
)

$ErrorActionPreference = 'Stop'
$sourceRoot = Split-Path -Parent $PSScriptRoot
$validator = Join-Path $CodexSkillsRoot '.system\skill-creator\scripts\quick_validate.py'

if (-not (Test-Path -LiteralPath $validator)) {
    throw "quick_validate.py was not found at $validator"
}

$skillDirectories = @(
    @{ Source = $sourceRoot; Name = 'industrial-control-cpp-style' },
    @{ Source = Join-Path $sourceRoot 'skills\industrial-control-cpp-review'; Name = 'industrial-control-cpp-review' },
    @{ Source = Join-Path $sourceRoot 'skills\industrial-control-cpp-audit'; Name = 'industrial-control-cpp-audit' },
    @{ Source = Join-Path $sourceRoot 'skills\industrial-control-cpp-debt'; Name = 'industrial-control-cpp-debt' },
    @{ Source = Join-Path $sourceRoot 'skills\industrial-control-cpp-help'; Name = 'industrial-control-cpp-help' }
)

foreach ($entry in $skillDirectories) {
    $destination = Join-Path $CodexSkillsRoot $entry.Name
    if (Test-Path -LiteralPath $destination) {
        Remove-Item -LiteralPath $destination -Recurse -Force
    }
    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $entry.Source 'SKILL.md') -Destination $destination
    if (Test-Path -LiteralPath (Join-Path $entry.Source 'agents')) {
        Copy-Item -LiteralPath (Join-Path $entry.Source 'agents') -Destination $destination -Recurse
    }
    if ($entry.Name -eq 'industrial-control-cpp-style') {
        Copy-Item -LiteralPath (Join-Path $entry.Source 'references') -Destination $destination -Recurse
    }
    & python $validator $destination
    if ($LASTEXITCODE -ne 0) {
        throw "Skill validation failed for $($entry.Name)"
    }
}

Write-Output "Synced $($skillDirectories.Count) industrial-control skills to $CodexSkillsRoot"
