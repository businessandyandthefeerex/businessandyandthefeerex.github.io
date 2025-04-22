require 'yaml'
require 'csv'
require 'date' 

# Path to your Jekyll posts directory
POSTS_DIR = "_posts"
OUTPUT_CSV = "assets/mymaps_export.csv"

# Prepare the CSV output
CSV.open(OUTPUT_CSV, "w", force_quotes: true) do |csv|
  csv << ["Name", "Address", "Description"]  # Google My Maps expects these headers

  Dir.glob("#{POSTS_DIR}/**/*.md").each do |file|
    content = File.read(file)

    if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      front_matter = YAML.safe_load($1, permitted_classes: [Date])

      title = front_matter['title']
      address = front_matter['address']
      country = front_matter['country']
      rating = front_matter['rating']

      full_address = [address, country].compact.join(", ")
      description = "Rating: #{rating}"

      # Only write the row if it has at least title and address
      if title && address && country
        csv << [title, full_address, description]
      end
    end
  end
end

puts "✅ Exported data to #{OUTPUT_CSV}"
