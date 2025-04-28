# Path to the _posts folder
posts_folder = '_posts'

# Collect all non-directory, non-hidden files
files = Dir.entries(posts_folder).select do |filename|
  File.file?(File.join(posts_folder, filename)) && !filename.start_with?('.')
end

puts "Fixing filenames for #{files.size} posts"

files.each do |filename|
  # If filename contains spaces, replace them with hyphens
  new_filename = filename.gsub(' ', '-')

  # Only rename if the filename has changed
  if new_filename != filename
    old_filepath = File.join(posts_folder, filename)
    new_filepath = File.join(posts_folder, new_filename)
    
    # Rename the file
    File.rename(old_filepath, new_filepath)
    puts "Renamed '#{filename}' to '#{new_filename}'"
  end
end
