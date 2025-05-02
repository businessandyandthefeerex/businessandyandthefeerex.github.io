require 'yaml'
require 'date'
require 'fileutils'

# Print the number of posts being processed
post_files = Dir.glob("_posts/*.md")
puts "Fixing filenames for #{post_files.length} posts"

# Loop through all posts in the _posts folder
post_files.each do |file|
  # Read the front matter from the file
  front_matter = YAML.safe_load(File.read(file), permitted_classes: [Date])

  # Extract the date from front matter or use the current date if not found
  post_date = front_matter['date']
  if post_date.nil?
    puts "No date found in front matter for #{file}, skipping"
    next
  end

  # Ensure the date is in the correct format (yyyy-mm-dd)
  formatted_date = post_date.strftime("%Y-%m-%d")

  # Extract the title from front matter
  post_title = front_matter['title']
  if post_title.nil? || post_title.strip.empty?
    puts "No title found in front matter for #{file}, skipping"
    next
  end

  # Sanitize title for filename and XML safety
  sanitized_title = post_title.strip
                               .gsub('&', 'and')              # replace ampersands
                               .gsub(/[<>"']/, '')            # remove <, >, ", '
                               .gsub(/\s+/, '-')              # spaces to hyphens
                               .gsub(/-+/, '-')               # collapse multiple hyphens
                               .gsub(/[^a-zA-Z0-9\-]/, '')    # remove anything else weird
                               .downcase

  # Extract the filename without the directory path
  filename = File.basename(file)

  # Construct the new filename with the date at the start and title as the rest
  new_filename = "#{formatted_date}-#{sanitized_title}.md".downcase

  # Construct the full path for the new filename
  new_file_path = File.join(File.dirname(file), new_filename)

  # Check if the new filename already exists
  if File.expand_path(file) == File.expand_path(new_file_path)
    # Same path, but maybe different case — force rename using a temp file
    temp_file_path = new_file_path + ".tmp"
    FileUtils.mv(file, temp_file_path)
    FileUtils.mv(temp_file_path, new_file_path)
    puts "Force-renamed '#{filename}' to '#{new_filename}' (case change only)"
  elsif File.exist?(new_file_path)
    puts "The file '#{new_filename}' already exists. Skipping renaming for '#{filename}'"
  else
    FileUtils.mv(file, new_file_path)
    puts "Renamed '#{filename}' to '#{new_filename}'"
  end
  
end
