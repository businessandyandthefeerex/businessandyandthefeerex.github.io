# require 'yaml'
# require 'fileutils'
# require 'set'
# require 'date'
# require 'active_support/inflector'

# CONFIG_FILE = '_config.yml'
# CONTENT_DIR = '_posts' # or change to '_reviews' if needed
# COLLECTION_ROOT = ''  # Use empty string to prevent double underscores

# # Slugify a string
# def slugify(text)
#   text.to_s.downcase.strip.gsub(/[^\w\- ]+/, '').gsub(/[ ]+/, '-')
# end

# # Read YAML front matter from a Jekyll file
# def read_front_matter(file_path)
#   content = File.read(file_path)
#   if content =~ /\A---\s*\n(.*?)\n?^---\s*$/m
#     YAML.safe_load($1, permitted_classes: [Date]) || {}
#   else
#     {}
#   end
# end

# # Read _config.yml and extract collection names
# def get_collections_from_config
#   config = YAML.load_file(CONFIG_FILE)
#   config['collections'] || {}
# end

# # Create or update the content of the country page with links to regions
# def update_country_page(country, region_links)
#     country_slug = slugify(country)
#     country_page_dir = "#{COLLECTION_ROOT}_countries"  # Correct directory with a single underscore
#     FileUtils.mkdir_p(country_page_dir) # Ensure the directory exists
#     country_page_path = File.join(country_page_dir, "#{country_slug}.md")
  
#     # Create or update the country page
#     File.open(country_page_path, 'w') do |file|
#       file.puts "---"
#       file.puts "title: #{country}"
#       file.puts "slug: #{country_slug}"
#       file.puts "layout: page"
#       file.puts "---"
  
#       # Ensure regions are unique by using a Set
#       unique_region_links = region_links.uniq { |link| link[:name] }
  
#       file.puts "Regions:"
#       unique_region_links.each do |region_link|
#         region_slug = slugify(region_link[:name])
#         file.puts "* [#{region_link[:name]}](/regions/#{region_slug}/)"
#       end
#     end
#   end
  

# # Create or update the content of the region page with links to reviews grouped by suburb and rating
# def update_region_page(region, posts)
#     region_slug = slugify(region)
#     region_page_dir = "#{COLLECTION_ROOT}_regions"  # Correct directory with a single underscore
#     FileUtils.mkdir_p(region_page_dir) # Ensure the directory exists
#     region_page_path = File.join(region_page_dir, "#{region_slug}.md")
  
#     # Group posts by suburb first, then by rating
#     grouped_by_suburb = posts.group_by { |post| post[:suburb] }
    
#     File.open(region_page_path, 'w') do |file|
#       file.puts "---"
#       file.puts "title: #{region}"
#       file.puts "slug: #{region_slug}"
#       file.puts "layout: page"
#       file.puts "---"
#       file.puts "Reviews:"
  
#       # For each suburb in the region
#       grouped_by_suburb.each do |suburb, suburb_posts|
#         file.puts "## #{suburb}"
        
#         # Group by rating within each suburb
#         grouped_by_rating = suburb_posts.group_by { |post| post[:rating] }
        
#         # For each rating in the suburb
#         grouped_by_rating.each do |rating, rating_posts|
#           file.puts "### Rating: #{rating}"
  
#           # List the reviews for the given suburb and rating
#           rating_posts.each do |post|
#             file.puts "* [#{post[:title]}](#{post[:path]})"
#           end
#         end
#       end
#     end
#   end  

# # Main
# collections = get_collections_from_config

# # We'll only auto-generate collections where the collection name matches a front matter field
# # e.g. 'country' → '_countries/', 'region' → '_regions/'
# auto_collections = collections.keys.select do |key|
#   key.is_a?(String) && !%w[posts drafts].include?(key)
# end

# puts "🔍 Will generate collections for: #{auto_collections.join(', ')}"

# # Extract unique values from posts
# values = Hash.new { |h, k| h[k] = Set.new }
# regions_by_country = Hash.new { |h, k| h[k] = [] }
# posts_by_region = Hash.new { |h, k| h[k] = [] }

# Dir.glob("#{CONTENT_DIR}/**/*.md").each do |file|
#   front_matter = read_front_matter(file)
#   auto_collections.each do |field|
#     value = front_matter[field]
#     if value
#       values[field] << value
#       if field == 'region'
#         country = front_matter['country']
#         regions_by_country[country] << value
#         posts_by_region[value] << { title: front_matter['title'], path: file }
#       end
#     end
#   end
# end

# # Create markdown file for each unique value in each collection
# values.each do |field, value_set|
#   plural = field.pluralize
#   dir = File.join("#{COLLECTION_ROOT}_#{plural}")  # Add only one underscore here
#   FileUtils.mkdir_p(dir)

#   value_set.each do |value|
#     slug = slugify(value)
#     path = File.join(dir, "#{slug}.md")

#     next if File.exist?(path)

#     File.open(path, 'w') do |file|
#       file.puts "---"
#       file.puts "title: #{value}"
#       file.puts "slug: #{slug}"
#       file.puts "layout: page"
#       file.puts "---"
#     end

#     puts "✅ Created #{path}"
#   end
# end

# # Update country pages with links to regions
# regions_by_country.each do |country, regions|
#   region_links = regions.map do |region|
#     { name: region, path: "_regions/#{slugify(region)}.md" }
#   end
#   update_country_page(country, region_links)
# end

# # Update region pages with links to posts
# posts_by_region.each do |region, posts|
#   post_links = posts.map do |post|
#     { title: post[:title], path: post[:path] }
#   end
#   update_region_page(region, post_links)
# end



##################################################################################################################################################
##################################################################################################################################################
##################################################################################################################################################
##################################################################################################################################################




require 'yaml'
require 'fileutils'
require 'date'

POSTS_DIR = "_posts"
TARGET_KEYS = %w[category rating meal country region suburb]

def slugify(str)
  str.downcase.strip.gsub(/[^\w\s-]/, '').gsub(/\s+/, '-')
end

collection_data = Hash.new { |h, k| h[k] = Set.new }

# Step 1: Parse all posts and collect collection data
Dir.glob("#{POSTS_DIR}/*.md").each do |post_file|
  content = File.read(post_file)
  if content =~ /\A---\s*\n(.*?)\n?---\s*\n/m
    front_matter = YAML.safe_load($1, permitted_classes: [Date])
    TARGET_KEYS.each do |key|
      value = front_matter[key]
      next unless value
      collection_data[key] << value
    end
  end
end

# Step 2: Create collection directories and index pages for each collection
collection_data.each do |key, values|
  dir = "_#{key}"

  # Remove existing directory and its contents
  FileUtils.rm_rf(dir)
  FileUtils.mkdir_p(dir)

  # Create index.md for the collection itself
  index_file = File.join(dir, "index.md")
  File.write(index_file, <<~MARKDOWN)
    ---
    layout: page
    title: "#{key.capitalize} Index"
    permalink: /#{key}/
    ---

    This is the index page for the `#{key}` collection.

    <ul>
        {% assign all_values = site.#{key} | sort: "title" %}
        {% for item in all_values %}
            {% unless item.url == page.url %}
                <li><a href="{{ item.url }}">{{ item.title }}</a></li>
            {% endunless %}
        {% endfor %}
    </ul>
  MARKDOWN

  puts "Created index: #{index_file}"

  # Step 3: Create pages for each value within the collection
  values.each do |value|
    slug = slugify(value.to_s)
    file_path = File.join(dir, "#{slug}.md")
    next if File.exist?(file_path)

    File.write(file_path, <<~MARKDOWN)
    ---
    layout: page
    title: "#{value}"
    #{key}: "#{value}"
    ---
      
    This is an index page for **#{value}** in the `#{key}` collection.

    <ul>
        {% assign key = "#{key}" %}
        {% assign value = page[key] %}

        {% for post in site.posts %}
            {% if post[key] == value %}
                <li><a href="{{ post.url }}">{{ post.title }}</a></li>
            {% endif %}
        {% endfor %}
    </ul>
    MARKDOWN

    puts "Created: #{file_path}"
  end
end