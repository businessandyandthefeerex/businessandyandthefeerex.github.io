require 'yaml'
require 'date'

# Path to the _posts folder
posts_folder = '_posts'

# Regular expression to match a date at the start of the filename
date_prefix_regex = /^\d{4}-\d{2}-\d{2}-/

# Collect all non-directory, non-hidden files
files = Dir.entries(posts_folder).select do |filename|
  File.file?(File.join(posts_folder, filename)) && !filename.start_with?('.')
end

puts "Fixing filenames for #{files.size} posts"

files.each do |filename|
  filepath = File.join(posts_folder, filename)

  # First, replace spaces with hyphens
  new_filename = filename.gsub(' ', '-')

  # Check if the filename starts with a date
  unless new_filename.match?(date_prefix_regex)
    # Read the front matter to find the date
    content = File.read(filepath)
    if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      front_matter = YAML.safe_load($1)

      if front_matter['date']
        post_date = Date.parse(front_matter['date'].to_s) rescue nil

        if post_date
          date_prefix = post_date.strftime('%Y-%m-%d')
          new_filename = "#{date_prefix}-#{new_filename}"
        else
          puts "Warning: Could not parse date in '#{filename}'"
          next
        end
      else
        puts "Warning: No date found in front matter of '#{filename}'"
        next
      end
    else
      puts "Warning: No front matter found in '#{filename}'"
      next
    end
  end

  # Only rename if the filename has changed
  if new_filename != filename
    old_filepath = File.join(posts_folder, filename)
    new_filepath = File.join(posts_folder, new_filename)
    
    if File.exist?(new_filepath)
      puts "Error: Cannot rename '#{filename}' to '#{new_filename}' because target already exists."
      next
    end

    File.rename(old_filepath, new_filepath)
    puts "Renamed '#{filename}' to '#{new_filename}'"
  end
end
