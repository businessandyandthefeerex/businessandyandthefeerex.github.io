Get-ChildItem .\posts\*.md |
ForEach-Object {
    $content = Get-Content $_.FullName

    $title = ($content | Select-String "^title:").ToString()
    $title = $title -replace "^title:\s*", ""

    [PSCustomObject]@{
        filename = $_.Name
        title = $title
        address = ""
        website = ""
    }
} | Export-Csv .\venues.csv -NoTypeInformation -Encoding UTF8