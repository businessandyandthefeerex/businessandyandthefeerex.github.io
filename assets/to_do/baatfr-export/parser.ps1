$inputFile = ".\ratings_backup.txt"
$outputFile = ".\ratings_backup.csv"

$content = Get-Content $inputFile

$records = @()
$current = $null

foreach ($line in $content) {

    # Restaurant title lines (not indented, not warnings, not summary)
    if ($line -match "^[^\s].*$" -and
        $line -notmatch "^WARNING:" -and
        $line -notmatch "^Updated:" -and
        $line -notmatch "^Missing") {

        if ($current) {
            $records += [PSCustomObject]$current
        }

        $current = @{
            title = $line.Trim()
            date = ""
            rating = ""
            meal = ""
            filename = ""
        }
    }

    elseif ($line -match "^\s+date:\s*(.*)") {
        $current.date = $matches[1].Trim()
    }

    elseif ($line -match "^\s+rating:\s*(.*)") {
        $current.rating = $matches[1].Trim()
    }

    elseif ($line -match "^\s+meal:\s*(.*)") {
        $current.meal = $matches[1].Trim()
    }

    elseif ($line -match "^\s+filename:\s*(.*)") {
        $current.filename = $matches[1].Trim()
    }
}

if ($current) {
    $records += [PSCustomObject]$current
}

$records | Export-Csv $outputFile -NoTypeInformation

Write-Host "Created $outputFile with $($records.Count) ratings"