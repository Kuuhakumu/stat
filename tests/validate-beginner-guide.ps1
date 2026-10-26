param(
    [switch]$Final
)

$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$beginner = Join-Path $root 'beginner'
$errors = @()
$warnings = @()

function New-TextFromCodePoints {
    param([int[]]$CodePoints)

    return -join ($CodePoints | ForEach-Object { [char]$_ })
}

$goalHeading = '## ' + (New-TextFromCodePoints @(0x0E40, 0x0E1B, 0x0E49, 0x0E32, 0x0E2B, 0x0E21, 0x0E32, 0x0E22))
$practiceHeading = '## ' + (New-TextFromCodePoints @(0x0E41, 0x0E1A, 0x0E1A, 0x0E1D, 0x0E36, 0x0E01, 0x0E2B, 0x0E31, 0x0E14, 0x0E1B, 0x0E34, 0x0E14, 0x0E2B, 0x0E19, 0x0E31, 0x0E07, 0x0E2A, 0x0E37, 0x0E2D))
$nextHeading = '## ' + (New-TextFromCodePoints @(0x0E44, 0x0E1B, 0x0E15, 0x0E48, 0x0E2D))

$requiredFiles = @(
    'README.md',
    'beginner/README.md',
    'beginner/before-you-start.md',
    'beginner/00-concept-map.md',
    'beginner/01-math-toolkit.md',
    'beginner/02-probability-and-random-variables.md',
    'beginner/03-discrete-uniform-and-bernoulli.md',
    'beginner/04-binomial.md',
    'beginner/05-poisson.md',
    'beginner/06-continuous-uniform-and-exponential.md',
    'beginner/07-normal-and-z-table.md',
    'beginner/08-normal-word-problems.md',
    'beginner/09-homework-ch4.md',
    'beginner/10-sampling-and-statistics.md',
    'beginner/11-sampling-distribution-of-mean.md',
    'beginner/12-t-distribution.md',
    'beginner/13-sampling-distribution-of-proportion.md',
    'beginner/14-difference-of-two-means.md',
    'beginner/15-difference-of-two-proportions.md',
    'beginner/16-estimation-basics.md',
    'beginner/17-ci-one-mean.md',
    'beginner/18-ci-one-proportion.md',
    'beginner/19-ci-two-means.md',
    'beginner/20-ci-paired-and-two-proportions.md',
    'beginner/21-homework-ch6.md',
    'beginner/22-hypothesis-testing-idea.md',
    'beginner/23-test-one-mean.md',
    'beginner/24-test-one-proportion.md',
    'beginner/25-test-two-means.md',
    'beginner/26-test-paired.md',
    'beginner/27-test-two-proportions.md',
    'beginner/28-homework-ch7.md',
    'beginner/29-choose-the-right-formula.md',
    'beginner/30-exam-rehearsal.md',
    'beginner/31-exam-rehearsal-b.md',
    'beginner/32-solo-homework.md',
    'beginner/formula-sheet.md',
    'beginner/tables-guide.md',
    'beginner/glossary.md',
    'beginner/last-few-hours.md',
    'beginner/slide-coverage.md',
    'tests/validate-beginner-guide.ps1',
    'docs/audit-report.md'
)

if (-not (Test-Path -LiteralPath $beginner -PathType Container)) {
    $errors += 'Beginner route directory is missing: beginner/'
}

$lessonFiles = @()
$beginnerFiles = @()
if (Test-Path -LiteralPath $beginner -PathType Container) {
    $beginnerFiles = @(Get-ChildItem -LiteralPath $beginner -Recurse -File)
    $lessonFiles = @(Get-ChildItem -LiteralPath $beginner -Filter '*.md' -File | Where-Object {
        $_.Name -match '^\d{2}-' -and $_.Name -ne '00-concept-map.md'
    })
}

foreach ($lesson in $lessonFiles) {
    $text = [System.IO.File]::ReadAllText($lesson.FullName, [System.Text.Encoding]::UTF8)
    $h2Count = @($text -split "`r?`n" | Where-Object { $_ -match '^## ' }).Count
    $isHomework = $lesson.Name -match '^(09|21|28|30|31|32)-'

    if ($isHomework) {
        if (-not $text.Contains($goalHeading)) {
            $errors += "$($lesson.Name) must contain the goal heading."
        }
    }
    else {
        if ($h2Count -lt 3) {
            $errors += "$($lesson.Name) needs at least three level-2 headings."
        }
        foreach ($heading in @($goalHeading, $practiceHeading, $nextHeading)) {
            if (-not $text.Contains($heading)) {
                $errors += "$($lesson.Name) is missing required heading: $heading"
            }
        }
    }

    $openDetails = [regex]::Matches($text, '<details>').Count
    $closeDetails = [regex]::Matches($text, '</details>').Count
    if ($openDetails -eq 0) {
        $errors += "$($lesson.Name) must contain a <details> block."
    }
    if ($openDetails -ne $closeDetails) {
        $errors += "$($lesson.Name) has $openDetails <details> tag(s) and $closeDetails closing tag(s)."
    }
}

foreach ($file in $beginnerFiles) {
    $text = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ([regex]::IsMatch($text, '\\frac|\\sqrt|\$\$')) {
        $errors += "LaTeX marker found in beginner/$($file.FullName.Substring($beginner.Length + 1))"
    }
}

if ($Final) {
    foreach ($file in $requiredFiles) {
        $path = Join-Path $root $file
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            $errors += "Required target-structure file is missing: $file"
        }
    }
}

$markdownFiles = @(Get-ChildItem -LiteralPath $root -Recurse -Filter '*.md' -File | Where-Object {
    $_.FullName -notmatch '[\\/]\.git[\\/]'
})
$brokenLinks = @()
foreach ($source in $markdownFiles) {
    $inFence = $false
    foreach ($line in [System.IO.File]::ReadAllLines($source.FullName, [System.Text.Encoding]::UTF8)) {
        if ($line -match '^\s*```') {
            $inFence = -not $inFence
            continue
        }
        if ($inFence) { continue }

        foreach ($match in [regex]::Matches($line, '\[[^\]]+\]\(([^)]+)\)')) {
            $target = $match.Groups[1].Value.Trim()
            if ($target -match '^(https?://|mailto:|#)') { continue }
            $target = ($target -split '#')[0]
            if (-not $target) { continue }

            $targetPath = Join-Path $source.DirectoryName $target
            if (-not (Test-Path -LiteralPath $targetPath)) {
                $brokenLinks += "$($source.FullName): $target"
            }
        }
    }
}

if ($brokenLinks.Count -gt 0) {
    foreach ($link in $brokenLinks) {
        if ($Final) {
            $errors += "Broken Markdown link: $link"
        }
        else {
            $warnings += "Broken Markdown link: $link"
        }
    }
}

if ($Final) {
    $allBeginnerText = (($beginnerFiles | Where-Object { $_.Extension -eq '.md' } | ForEach-Object {
        [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    }) -join "`n")

    $requiredExampleIds = @()
    foreach ($number in 1..21) { $requiredExampleIds += "EX 4.$number" }
    foreach ($number in 1..16) { $requiredExampleIds += "EX 5.$number" }
    foreach ($number in 1..11) { $requiredExampleIds += "EX 6.$number" }
    $requiredExampleIds += 'EX 7.1', 'EX 7.2'
    foreach ($number in 4..16) { $requiredExampleIds += "EX 7.$number" }
    foreach ($exampleId in $requiredExampleIds) {
        if (-not $allBeginnerText.Contains($exampleId)) {
            $errors += "Beginner route is missing example ID: $exampleId"
        }
    }

    if (-not (Test-Path -LiteralPath (Join-Path $beginner 'slide-coverage.md') -PathType Leaf)) {
        $errors += 'beginner/slide-coverage.md is missing.'
    }

    $subscriptZero = [string][char]0x2080
    $subscriptOne = [string][char]0x2081
    $requiredTerms = @(
        'Binomial', 'Poisson', 'Normal', 'Z', 't', 'Central Limit Theorem',
        'Confidence interval', ('H' + $subscriptZero), ('H' + $subscriptOne),
        'Type I error', 'Type II error', 'p-value', 'degrees of freedom',
        'pooled', 'paired'
    )
    foreach ($term in $requiredTerms) {
        if (-not $allBeginnerText.Contains($term)) {
            $errors += "Beginner route is missing required term: $term"
        }
    }
}

foreach ($warning in $warnings) {
    Write-Warning $warning
}

if ($errors.Count -gt 0) {
    throw ("Beginner route validation failed:`n - " + ($errors -join "`n - "))
}

Write-Output "Beginner route validation passed: $($lessonFiles.Count) lessons checked."
