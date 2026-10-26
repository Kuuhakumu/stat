# Runs the next unchecked task from docs/plan/PROGRESS.md in a FRESH Codex session (GPT 6.1 sol).
# Usage:  powershell -ExecutionPolicy Bypass -File docs/plan/run-next-task.ps1 [-Task T05] [-Count 1]
param(
    [string]$Task = '',
    [int]$Count = 1
)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$progress = Join-Path $root 'docs\plan\PROGRESS.md'
$logDir = Join-Path $root 'docs\plan\logs'
New-Item -ItemType Directory -Force $logDir | Out-Null

for ($i = 0; $i -lt $Count; $i++) {
    $id = $Task
    if (-not $id) {
        $line = Get-Content -Encoding utf8 $progress | Where-Object { $_ -match '^- \[ \] (\S+)' } | Select-Object -First 1
        if (-not $line) { Write-Output 'All tasks are done.'; break }
        $id = [regex]::Match($line, '^- \[ \] (\S+)').Groups[1].Value
    }
    $card = Join-Path $root "docs\plan\tasks\$id.md"
    if (-not (Test-Path $card)) { throw "Task card not found: $card" }

    if ($id -eq 'T43') {
        Write-Output 'T43 publishes to GitHub and needs your answers. Run it in an interactive Codex session instead.'
        break
    }

    $prompt = "Read docs/plan/STYLE.md, then do exactly the task in docs/plan/tasks/$id.md. Nothing else. When finished, reply with one line: DONE $id"
    $log = Join-Path $logDir "$id.log"
    $promptFile = Join-Path $logDir "$id.prompt.txt"
    [System.IO.File]::WriteAllText($promptFile, $prompt)
    Write-Output "Running $id in a fresh Codex session (log: $log) ..."
    # Run through cmd so Codex's stderr banner never reaches PowerShell (PS 5.1 turns it into a terminating error).
    $ErrorActionPreference = 'Continue'
    & cmd.exe /d /c "codex.cmd exec --skip-git-repo-check -s workspace-write -C `"$root`" - < `"$promptFile`" > `"$log`" 2>&1"
    $exit = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    Remove-Item $promptFile -ErrorAction SilentlyContinue
    if ($exit -ne 0) {
        Write-Output "WARNING: codex exited with code $exit for $id. Read $log."
    }

    $research = 'CH4a','CH4b','CH5a','CH5b','CH6','CH7a','CH7b','TABLES','HOMEWORK'
    $missing = $research | Where-Object { -not (Test-Path (Join-Path $root "docs\research\$_.md")) }
    if ($missing) {
        Write-Output "STOP: research notes were deleted by $id ($($missing -join ', ')). Their text is recoverable from docs/research/logs or $log."
        break
    }

    $ticked = Get-Content -Encoding utf8 $progress | Where-Object { $_ -match "^- \[x\] $id\b" }
    if (-not $ticked) {
        Write-Output "WARNING: $id did not tick itself in PROGRESS.md. Read $log before continuing."
        break
    }
    Write-Output "$id done."
    $Task = ''
}
