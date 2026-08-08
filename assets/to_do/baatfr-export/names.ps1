# Import the CSV
$posts = Import-Csv ".\posts.csv"

# Create a lookup table
$lookup = @{}
foreach ($post in $posts) {
    $date = (Get-Date $post."First Published Date").ToString("yyyy-MM-dd")
    $lookup[$post.Slug] = $date
}

# Process every markdown file
Get-ChildItem *.md | ForEach-Object {

    $file = $_

    # Extract slug from filename
    if ($file.BaseName -match '^\d{4}-\d{2}-\d{2}-(.+)$') {

        $slug = $Matches[1]

        if ($lookup.ContainsKey($slug)) {

            $date = $lookup[$slug]

            Write-Host "Updating $slug -> $date"

            # Read file
            $content = Get-Content $file.FullName -Raw

            # Replace front matter date
            $content = $content -replace '(?m)^date:.*$', "date: $date"

            # Save
            Set-Content $file.FullName $content -NoNewline

            # Rename file
            $newName = "$date-$slug.md"

            if ($file.Name -ne $newName) {
                Rename-Item $file.FullName $newName
            }
        }
        else {
            Write-Warning "No CSV match for '$slug'"
        }
    }
}