# generate_regions.rb

require 'yaml'
require 'fileutils'

POSTS_DIR = "_posts"
OUTPUT_DIR = "locations/nz"
LAYOUT = "region"

FileUtils.mkdir_p(OUTPUT_DIR)
regions = []

Dir.glob("#{POSTS_DIR}/**/*.md") do |post_file|
  content = File.read(post_file)
  if content =~ /\A---\s*\n.*?\n---\s*\n/m
    front_matter = content.match(/\A---\s*\n(.*?)\n---\s*\n/m)[1]
    data = YAML.load(front_matter)

    if data["country"] == "New Zealand" && data["region"]
      regions << data["region"]
    end
  end
end

regions.uniq.sort.each do |region|
  slug = region.downcase.gsub(" ", "-")
  filename = "#{OUTPUT_DIR}/#{slug}.md"

  File.open(filename, "w") do |file|
    file.puts <<~MARKDOWN
      ---
      layout: #{LAYOUT}
      title: Reviews in #{region}
      region: #{region}
      country: New Zealand
      permalink: /locations/nz/#{slug}/
      ---

      <!-- Auto-generated region page -->
    MARKDOWN
  end

  puts "✅ Created: #{filename}"
end
