require 'yaml'
require 'csv'
require 'date'

POSTS_DIR = "_posts"
OUTPUT_CSV = "assets/mymaps_export.csv"
SITE_BASEURL = "https://businessandyandthefeerex.co.nz/reviews" 

CSV.open(OUTPUT_CSV, "w", force_quotes: true) do |csv|
  csv << ["Name", "Address", "Description", "URL"]

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

      # Build the post URL
      filename = File.basename(file, ".md")
      if filename =~ /^(\d{4})-(\d{2})-(\d{2})-(.*)$/
        year, month, day, slug = $1, $2, $3, $4
        url = "#{SITE_BASEURL}/#{year}/#{month}/#{day}/#{slug}/"
      else
        url = ""
      end

      if title && address && country
        csv << [title, full_address, description, url]
      end
    end
  end
end

puts "Created: #{OUTPUT_CSV}"
