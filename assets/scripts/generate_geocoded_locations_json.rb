require 'yaml'
require 'net/http'
require 'uri'
require 'json'
require 'date'

API_KEY = 'pk.fe3e3d7375f7b8575b4749d9c3359004'
POSTS_DIR = "_posts"
OUTPUT_FILE = "assets/geocoded_locations.json"
MARKERS_FILE = "assets/markers.yml"  # New markers file for Leaflet

# Load existing geocoded locations from the output file, if it exists
def load_geocoded_locations
  if File.exist?(OUTPUT_FILE)
    file = File.read(OUTPUT_FILE)
    JSON.parse(file)
  else
    []
  end
end

# Check if the post has already been geocoded by address and country
def already_geocoded?(address, country, geocoded_locations)
  geocoded_locations.any? { |entry| entry["address"] == address && entry["country"] == country }
end

def geocode_address(address, country)
  query = "#{address}, #{country}"
  url = URI("https://us1.locationiq.com/v1/search.php?key=#{API_KEY}&q=#{URI.encode_www_form_component(query)}&format=json")

  res = Net::HTTP.get_response(url)
  return nil unless res.is_a?(Net::HTTPSuccess)

  data = JSON.parse(res.body)
  return nil if data.empty?

  { lat: data[0]['lat'], lon: data[0]['lon'] }
rescue => e
  puts "Error geocoding #{query}: #{e.message}"
  nil
end

# Step 1: Load existing geocoded locations
geocoded_locations = load_geocoded_locations

results = []

# Step 2: Read all posts
posts = Dir.glob("#{POSTS_DIR}/*.md")
total_posts = posts.size

posts.each_with_index do |file, index|
  content = File.read(file)
  if content =~ /\A---\s*\n(.*?)\n?---\s*\n/m
    front_matter = YAML.safe_load($1, permitted_classes: [Date])

    address = front_matter['address']
    country = front_matter['country']
    title = front_matter['title']  # Extract title
    rating = front_matter['rating'] || 'No rating'  # Extract rating, default to 'No rating' if missing

    next unless address && country

    # Print progress
    puts "Processing post #{index + 1}/#{total_posts}: #{file}"

    # Check if this post has already been geocoded
    if already_geocoded?(address, country, geocoded_locations)
      puts "Skipping geocoding for previously processed location: #{address}, #{country}"
      next
    end

    puts "Geocoding: #{address}, #{country}"
    location = geocode_address(address, country)

    if location
      # Include title and rating in the result
      results << {
        file: File.basename(file),
        address: address,
        country: country,
        lat: location[:lat],
        lon: location[:lon],
        title: title,  # Add title to the result
        rating: rating  # Add rating to the result
      }
    else
      puts "Failed to geocode: #{address}, #{country}"
    end

    # Sleep to avoid hitting rate limits (LocationIQ suggests 1 request/sec for free tier)
    sleep 1
  end
end


# Step 3: Merge new results with existing locations and write output
geocoded_locations += results
File.open(OUTPUT_FILE, "w") do |f|
  f.write(JSON.pretty_generate(geocoded_locations))
end

puts "Geocoding complete. Results saved to #{OUTPUT_FILE}."
