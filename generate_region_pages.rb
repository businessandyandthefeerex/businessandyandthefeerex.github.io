require 'jekyll'
require 'fileutils'

# Initialize the Jekyll site object and set up the site environment
config = Jekyll.configuration({})
site = Jekyll::Site.new(config)

# This reads all files, including posts, into the site object
site.read

# Function to delete all files in a directory
def delete_all_files_in_directory(directory)
  if Dir.exist?(directory)
    Dir.foreach(directory) do |file|
      file_path = File.join(directory, file)
      if File.file?(file_path)
        File.delete(file_path)
      end
    end
  end
end

# Function to clear out empty country folders
def clean_country_folders
  country_dir = File.join(Dir.pwd, 'country')
  return unless Dir.exist?(country_dir)

  Dir.foreach(country_dir) do |entry|
    next if entry == '.' || entry == '..'
    path = File.join(country_dir, entry)
    FileUtils.rm_rf(path) if File.directory?(path)
  end
end

# Call it before generating anything
clean_country_folders

# Make sure the country directory exists
def create_directory(directory)
  FileUtils.mkdir_p(directory) unless Dir.exists?(directory)
end

# Now we can safely access the posts
countries = site.posts.docs.map { |post| post.data['country'] }.uniq

countries.each do |country|
  # Generate a slug for the country and create the folder path
  country_slug = country.downcase.gsub(" ", "-")
  country_folder = "country/#{country_slug}"

  # Delete all files in the country folder before proceeding
  delete_all_files_in_directory(country_folder)

  # Make sure the country folder exists
  Dir.mkdir(country_folder) unless File.exist?(country_folder)

  # Create the country page
  country_filename = "#{country_folder}/index.md"
  
  File.open(country_filename, "w") do |file|
    file.puts <<~MARKDOWN
      ---
      layout: page
      title: #{country}
      country: #{country}
      permalink: /country/#{country_slug}/
      ---
      [↑ Go to the list of all countries](/country/)
      <ul>
    MARKDOWN

    # Group all posts by country
    country_posts = site.posts.docs.select { |post| post.data['country'] == country }

    # Group the posts by region
    grouped_by_region = country_posts.group_by { |post| post.data['region'] }

    # Loop over each region in the country and create a list
    grouped_by_region.each do |region, region_posts|
      # Skip creating pages for nil or empty regions
      next if region.nil? || region.empty?

      # Generate a slug for the region
      region_slug = region.downcase.gsub(" ", "-")

      file.puts <<~MARKDOWN
        <li>
          <a href="/country/#{country_slug}/#{region_slug}/">#{region}</a>
        </li>
      MARKDOWN

      # Create a region page inside the country folder
      region_filename = "#{country_folder}/#{region_slug}.md"

      File.open(region_filename, "w") do |region_file|
        region_file.puts <<~MARKDOWN
          ---
          layout: page
          title: #{region}, #{country}
          region: #{region}
          country: #{country}
          permalink: /country/#{country_slug}/#{region_slug}/
          ---
          [↑ Go to #{country} regions](/country/#{country_slug}/)
          <ul>
            {% assign posts = site.posts | where: "region", "#{region}" | where: "country", "#{country}" %}
            {% assign grouped_posts = posts | group_by: "suburb" %}

            {% for group in grouped_posts %}
              <h3>{{ group.name }}</h3>

              <!-- Group posts by rating -->
              {% assign rating_groups = group.items | group_by: "rating" %}
              {% assign sorted_rating_groups = rating_groups | sort: "name" %}

              {% for rating_group in sorted_rating_groups reversed %}
                <h4>rating: {{ rating_group.name }}</h4>
                <ul>
                  {% for post in rating_group.items %}
                    <li>
                      <a href="{{ post.url }}">{{ post.title }}</a>
                    </li>
                  {% endfor %}
                </ul>
              {% endfor %}
            {% endfor %}
          </ul>
        MARKDOWN
      end
    end

    file.puts "</ul>"
  end

  puts "🔄 Generated: #{country_filename} with regions for country #{country}"
end

puts "🚀 Region pages generated for all countries."
