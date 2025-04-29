require 'date'

# Function to find and update the date in the front matter
def update_date_in_front_matter(file_path)
  # Read the content of the file
  content = File.read(file_path)

  # Regex pattern to match dates in the format "Aug 5, 2023" or "Oct 7, 2021", including "Updated:"
  date_pattern = /(?:Updated: )?([A-Za-z]+ \d{1,2},? \d{4})/

  # Search for the date in the file content
  match = content.match(date_pattern)
  return unless match

  # Extract the date string
  date_str = match[1]
  puts "Found date: #{date_str}" # Debugging output

  # Attempt to parse the date with multiple formats
  begin
    # Remove 'Updated: ' if it exists and normalize the date string
    normalized_date_str = date_str.gsub('Updated: ', '').gsub(',', '').strip
    parsed_date = Date.parse(normalized_date_str)
    # Format the date in "yyyy-mm-dd" format
    formatted_date = parsed_date.strftime('%Y-%m-%d')

    # Check and update the front matter (replace the existing date line)
    if content =~ /^---\s*\n(.*?)\n---/m
      front_matter = $1

      # Replace the existing date line with the new formatted date
      front_matter.sub!(/date:\s*\S+/, "date: #{formatted_date}")

      # Check that the front matter was modified
      puts "Updated front matter: #{front_matter}" # Debugging output

      # Rewrite the file with the updated front matter
      new_content = content.sub(/^---\s*\n(.*?)\n---/m, "---\n#{front_matter}\n---")
      
      # Write the new content to the file
      File.write(file_path, new_content)
      puts "Updated date in #{file_path} to #{formatted_date}"
    end
  rescue ArgumentError => e
    puts "Invalid date format found in #{file_path}: #{date_str}" # Show the date string that failed
  end
end

# Iterate through all markdown files in the current directory
Dir.glob('./*.md') do |file_path|
  update_date_in_front_matter(file_path)
end
