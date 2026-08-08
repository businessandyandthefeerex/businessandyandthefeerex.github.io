$csv = ".\ratings_backup.csv"
$folder = ".\BAATFR"

$updated = 0
$missing = 0

$ratings = Import-Csv $csv

foreach ($row in $ratings) {

    $file = Join-Path $folder $row.filename

    if (!(Test-Path $file)) {
        Write-Warning "Missing file: $($row.filename)"
        $missing++
        continue
    }

    $content = Get-Content $file -Raw

    # Only modify front matter
    if ($content -match "(?s)^---\s*\r?\n(.*?)\r?\n---") {

        $frontMatter = $matches[1]

        # Don't add duplicates
        if ($frontMatter -notmatch "(?m)^rating:") {

            $newFrontMatter = $frontMatter -replace `
                "(?m)^(date:.*)$", `
                "`$1`r`nrating: $($row.rating)"

            $newContent = $content -replace `
                "(?s)^---\s*\r?\n.*?\r?\n---", `
                "---`r`n$newFrontMatter`r`n---"

            Set-Content -Path $file -Value $newContent -Encoding UTF8

            Write-Host "Restored $($row.filename) -> rating $($row.rating)"
            $updated++
        }
        else {
            Write-Host "Already has rating: $($row.filename)"
        }

    }
    else {
        Write-Warning "No front matter found: $($row.filename)"
    }
}

Write-Host ""
Write-Host "Updated: $updated"
Write-Host "Missing: $missing"