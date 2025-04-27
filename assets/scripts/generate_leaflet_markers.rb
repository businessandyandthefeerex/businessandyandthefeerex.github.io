require 'json'
require 'yaml'

INPUT_FILE = "assets/geocoded_locations.json"
OUTPUT_FILE = "assets/markers.yml"

# Load geocoded locations from the JSON file
def load_geocoded_locations
  if File.exist?(INPUT_FILE)
    file = File.read(INPUT_FILE)
    JSON.parse(file)
  else
    []
  end
end

def generate_post_url(file_name)
    # Example file name: 2024-02-22-Stratosfare-Restaurant-&-Bar.md
    match = file_name.match(/^(\d{4})-(\d{2})-(\d{2})-(.*)\.md$/)
    
    if match
      year = match[1]
      month = match[2]
      day = match[3]
      slug = match[4]
  
      # Replace spaces with hyphens and keep the ampersands intact
      slug = slug.gsub(' ', '-') # Keep upper case letters
  
      # Return the formatted URL
      return "https://businessandyandthefeerex.co.nz/reviews/#{year}/#{month}/#{day}/#{slug}/"
    else
      return "#" # Return a fallback URL if filename doesn't match expected pattern
    end
end
  
  
  
  

# Step 1: Load geocoded locations
geocoded_locations = load_geocoded_locations

# Step 2: Create the markers.yml file
File.open(OUTPUT_FILE, "w") do |f|
  geocoded_locations.each do |location|
    # Assuming the location contains a reference to the post (e.g., 'file', 'rating', 'link' from your front matter)
    title = location['title'] # You may need to modify this based on how your posts are named or structured
    rating = location['rating'] || 'No rating'  # Default to 'No rating' if rating is missing
    post_url = generate_post_url(location['file'])  # Generate the post URL from the filename

    f.puts("- lat: #{location['lat']}")
    f.puts("  lon: #{location['lon']}")
    f.puts("  title: \"#{title}\"")
    f.puts("  address: \"#{location['address']}, #{location['country']}\"")
    f.puts("  rating: \"#{rating}\"")  # Add the rating
    f.puts("  link: \"#{post_url}\"")  # Add the link to the post
    f.puts("") # Adds a line break between entries
  end
end

puts "Markers file generated successfully and saved to #{OUTPUT_FILE}."
