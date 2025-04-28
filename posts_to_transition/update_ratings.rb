# Function to find and update the rating and title in the front matter
def update_rating_and_title_in_front_matter(file_path)
    # Read the content of the file
    content = File.read(file_path)
  
    # Debugging: Print the file content to make sure we're reading it correctly
    puts "Reading file: #{file_path}"
    puts content[0..200]  # Print the first 200 characters of the file for debugging
  
    # Extract filename without extension to use as title
    filename = File.basename(file_path, ".md")
    puts "Extracted filename as title: #{filename}" # Debugging output
  
    # Regex pattern to find rating in the body
    rating_pattern_in_body = /rating:\s*(\d+)/i  # Case-insensitive match
  
    # Search for the front matter block
    front_matter_match = content.match(/^---\s*\n(.*?)\n---/m)
    if front_matter_match
      front_matter = front_matter_match[1]
      puts "Found front matter: #{front_matter}" # Debugging output
    else
      puts "No front matter found in #{file_path}"
      return
    end
  
    # Find all occurrences of rating in the body
    body_ratings = content.scan(rating_pattern_in_body)
  
    if body_ratings.length >= 2
      # The second rating in the body (skipping the first one)
      body_rating = body_ratings[1][0]
      puts "Found second rating in body: #{body_rating}" # Debugging output
  
      # Replace the first rating in the front matter with the second rating from the body
      updated_front_matter = front_matter.sub(/rating:\s*(\d+)/i, "rating: #{body_rating}")
  
      # Insert or update the title with the filename (if not already in front matter)
      title_pattern_in_front_matter = /title:\s*(.+)/i  # Case-insensitive match for title
      if front_matter.match(title_pattern_in_front_matter)
        updated_front_matter = updated_front_matter.sub(title_pattern_in_front_matter, "title: #{filename}")
      else
        updated_front_matter = updated_front_matter + "\ntitle: #{filename}"
      end
  
      # Check if the front matter was updated
      if updated_front_matter != front_matter
        puts "Updating front matter for #{file_path}"
  
        # Rewrite the file with the updated front matter
        new_content = content.sub(/^---\s*\n(.*?)\n---/m, "---\n#{updated_front_matter}\n---")
  
        # Debugging: Check the new content before writing
        puts "New content preview: #{new_content[0..200]}"  # Print the first 200 characters of the new content
  
        # Write the new content to the file
        File.write(file_path, new_content)
        puts "Updated rating and title in front matter of #{file_path}"
      else
        puts "No change in front matter for #{file_path}"
      end
    else
      puts "Not enough ratings found in the body of #{file_path}"
    end
  end
  
  # Iterate through all markdown files in the current directory
  Dir.glob('./*.md') do |file_path|
    update_rating_and_title_in_front_matter(file_path)
  end