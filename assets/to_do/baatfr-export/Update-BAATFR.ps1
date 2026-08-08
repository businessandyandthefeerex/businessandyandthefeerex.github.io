param(
    [switch]$DryRun
)

$posts = @{}

Import-Csv ".\posts.csv" | ForEach-Object {
    $posts[$_.Title.Trim()] = $_
}

$updated = 0
$missing = 0

Get-ChildItem ".\BAATFR\*.md" | ForEach-Object {

    $file = $_

    $content = Get-Content $file.FullName -Raw


    if ($content -notmatch '(?m)^title:\s*(.+)$') {
        Write-Warning "No title found: $($file.Name)"
        return
    }


    $title = $Matches[1].Trim()


    if (-not $posts.ContainsKey($title)) {
        Write-Warning "No CSV match: $title"
        $missing++
        return
    }


    $post = $posts[$title]

    $date = (Get-Date $post.'First Published Date').ToString("yyyy-MM-dd")


    $rating = $null
    if ($content -match '(?m)^Rating:\s*(\d+)') {
        $rating = $Matches[1]
    }


    $meal = $null
    if ($content -match '(?i)We ate (breakfast|lunch|dinner|brunch|coffee)') {
        $meal = $Matches[1].ToLower()
    }


    if ($DryRun) {

        Write-Host ""
        Write-Host $title
        Write-Host "  date: $date"
        Write-Host "  rating: $rating"
        Write-Host "  meal: $meal"
        Write-Host "  filename: $date-$($post.Slug).md"

        return
    }


    $newContent = $content

    $newContent = $newContent -replace '(?m)^date:\s*.*$', "date: $date"


    if ($rating) {
        $newContent = $newContent -replace '(?m)^rating:\s*.*$', "rating: $rating"
        $newContent = $newContent -replace '(?m)^Rating:\s*\d+\s*\r?\n', ""
    }


    if ($meal) {
        $newContent = $newContent -replace '(?m)^meal:\s*.*$', "meal: $meal"
    }


    Set-Content $file.FullName $newContent -NoNewline


    $newName = "$date-$($post.Slug).md"

    if ($file.Name -ne $newName) {

        $destination = Join-Path $file.DirectoryName $newName

        if (Test-Path $destination) {
            Write-Warning "Cannot rename, already exists: $newName"
        }
        else {
            Rename-Item $file.FullName $newName
        }
    }


    Write-Host "Updated: $title"

    $updated++
}


Write-Host ""
Write-Host "Updated: $updated"
Write-Host "Missing CSV matches: $missing"