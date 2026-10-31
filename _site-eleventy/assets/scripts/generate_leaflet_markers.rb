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
  match = file_name.match(/^(\d{4})-(\d{2})-(\d{2})-(.*)\.md$/)
  if match
    year = match[1]
    month = match[2]
    day = match[3]
    slug = match[4]
    slug = slug.gsub(' ', '-') # Replace spaces with hyphens
    "https://businessandyandthefeerex.co.nz/reviews/#{year}/#{month}/#{day}/#{slug}/"
  else
    "#"
  end
end

# Step 1: Load geocoded locations
geocoded_locations = load_geocoded_locations

# Step 2: Create initial markers
markers = geocoded_locations.map do |location|
  {
    'lat' => location['lat'],
    'lon' => location['lon'],
    'title' => location['title'],
    'address' => "#{location['address']}, #{location['country']}",
    'rating' => location['rating'] || 'No rating',
    'link' => generate_post_url(location['file'])
  }
end

# Step 3: Deduplicate markers by lat, lon, and title
unique_markers = markers.uniq { |m| [m['lat'], m['lon'], m['title']] }

# Step 4: Write deduplicated markers to YAML
File.open(OUTPUT_FILE, "w") do |f|
  unique_markers.each do |marker|
    f.puts("- lat: #{marker['lat']}")
    f.puts("  lon: #{marker['lon']}")
    f.puts("  title: \"#{marker['title']}\"")
    f.puts("  address: \"#{marker['address']}\"")
    f.puts("  rating: \"#{marker['rating']}\"")
    f.puts("  link: \"#{marker['link']}\"")
    f.puts("")
  end
end

puts "Markers file generated and deduplicated successfully, saved to #{OUTPUT_FILE}."
