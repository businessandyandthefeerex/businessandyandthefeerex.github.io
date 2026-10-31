require 'fileutils'
require 'yaml'
require 'date'

# Read posts directly from _posts/*.md and parse front matter robustly (avoid Jekyll parsing errors)
def read_posts_from_files
  posts = []
  Dir["_posts/*.md"].sort.each do |f|
    raw = File.binread(f)
    clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
    # find all front-matter blocks
    blocks = clean.scan(/\A---\n(.*?)\n---\s*/m).map{|m| m[0]}
    fm = nil
    blocks.each do |b|
      begin
        data = YAML.safe_load(b, permitted_classes: [Date, Time], aliases: true) || {}
      rescue
        next
      end
      # pick first block that has at least one non-empty key value
      if data.is_a?(Hash) && data.values.any?{|v| v && v.to_s.strip != ''}
        fm = data
        break
      end
    end
    # fallback: try first block parse
    if fm.nil? && blocks.any?
      begin
        fm = YAML.safe_load(blocks.first, permitted_classes: [Date, Time], aliases: true) || {}
      rescue
        fm = {}
      end
    end
    posts << {path: f, data: (fm || {})}
  end
  posts
end

site_posts = read_posts_from_files

def delete_all_files_in_directory(directory)
  if Dir.exist?(directory)
    Dir.foreach(directory) do |file|
      file_path = File.join(directory, file)
      File.delete(file_path) if File.file?(file_path)
    end
  end
end

def clean_country_folders
  country_dir = File.join(Dir.pwd, '_country')
  return unless Dir.exist?(country_dir)

  Dir.foreach(country_dir) do |entry|
    next if entry == '.' || entry == '..'
    path = File.join(country_dir, entry)
    FileUtils.rm_rf(path) if File.directory?(path)
  end
end

clean_country_folders
puts "Cleaned _country/ directory"

def create_directory(directory)
  FileUtils.mkdir_p(directory) unless Dir.exists?(directory)
end

def normalize_text(value)
  value.to_s.strip
end

# Mirrors Jekyll's default `slugify` Liquid filter, so Ruby-built
# permalinks/file paths always match the slugs Liquid generates in links.
def slugify(text)
  text.to_s.downcase.gsub(/[^\p{Alnum}]+/, '-').gsub(/\A-+|-+\z/, '')
end

countries = site_posts.map { |post| post[:data]['country'] }.uniq

countries.each do |country|
  next if country.nil? || country.empty?

  country_slug = slugify(country)
  country_folder = "_country/#{country_slug}"

  delete_all_files_in_directory(country_folder)
  FileUtils.mkdir_p(country_folder) unless File.exist?(country_folder)

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

    country_posts = site_posts.select { |post| post[:data]['country'] == country }
    grouped_by_region = country_posts.group_by { |post| normalize_text(post[:data]['region']) }

    grouped_by_region
      .sort_by { |region, _| normalize_text(region).downcase }
      .each do |region, region_posts|

      region_name = normalize_text(region)
      next if region_name.empty?

      region_slug = slugify(region_name)

      file.puts <<~MARKDOWN
        <li>
          <a href="/country/#{country_slug}/#{region_slug}/">#{region_name}</a>
        </li>
      MARKDOWN

      region_filename = "#{country_folder}/#{region_slug}.md"

      File.open(region_filename, "w") do |region_file|
        region_file.puts <<~MARKDOWN
          ---
          layout: page
          title: #{region_name}, #{country}
          country: #{country}
          region: #{region_name}
          permalink: /country/#{country_slug}/#{region_slug}/
          ---
          [↑ Go to #{country} regions](/country/#{country_slug}/)

          {% assign posts = site.posts | where: "region", "#{region}" | where: "country", "#{country}" %}
          {% assign city_groups = posts | group_by: "city" %}
          {% assign sorted_city_groups = city_groups | sort: "name" %}

          {% for city_group in sorted_city_groups %}
          {% assign city_slug = city_group.name | downcase | slugify %}
          {% if city_group.name != "" %}
          - [{{ city_group.name }}](/country/#{country_slug}/#{region_slug}/{{ city_slug }}/)
          {% else %}
          - Unspecified city
          {% endif %}
          {% endfor %}
        MARKDOWN
      end
      puts "Created: _country/#{country_slug}/#{region_slug}/"

      # Create city pages: each city page lists its suburbs, each suburb's
      # posts grouped by rating.
      city_groups = region_posts.group_by { |post| post[:data]['city'] }
      city_groups.each do |city, city_posts|
        city_name = normalize_text(city)
        next if city_name.empty?

        city_slug = slugify(city_name)
        city_folder = "#{country_folder}/#{region_slug}"
        city_filename = "#{city_folder}/#{city_slug}.md"

        FileUtils.mkdir_p(city_folder) unless File.exist?(city_folder)

        File.open(city_filename, "w") do |city_file|
          city_file.puts <<~MARKDOWN
            ---
            layout: page
            title: #{city_name}, #{region_name}, #{country}
            country: #{country}
            region: #{region_name}
            city: #{city_name}
            permalink: /country/#{country_slug}/#{region_slug}/#{city_slug}/
            ---
            [↑ Go to #{region_name}](/country/#{country_slug}/#{region_slug}/)

            {% assign posts = site.posts | where: "country", "#{country}" | where: "region", "#{region}" | where: "city", "#{city}" %}
            {% assign suburb_groups = posts | group_by: "suburb" %}
            {% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

            {% for group in sorted_suburb_groups %}
            {% if group.name != "" %}
            #### {{ group.name }}
            {% else %}
            #### Unspecified suburb
            {% endif %}

            {% assign rating_groups = group.items | group_by: "rating" %}
            {% assign sorted_rating_groups = rating_groups | sort: "name" %}

            {% for rating_group in sorted_rating_groups reversed %}
            ##### Rating: {{ rating_group.name }}

            {% for post in rating_group.items %}
            - [{{ post.title }}]({{ post.url }})
            {% endfor %}

            {% endfor %}
            {% endfor %}
          MARKDOWN
        end

        puts "Created: _country/#{country_slug}/#{region_slug}/#{city_slug}/"
      end
    end

    file.puts "</ul>"
  end

  puts "Created: _country/#{country_slug}/"
end

# Ensure the _country directory exists
FileUtils.mkdir_p("_country") unless Dir.exist?("_country")

# Create the index.md file inside the _country folder
File.open("_country/index.md", "w") do |file|
  file.puts <<~MARKDOWN
    ---
    layout: page
    title: All Countries
    permalink: /country/
    ---
    [↑ Go to the Browse by Region page](/regions/)

    <ul>
  MARKDOWN

  countries.sort_by { |c| c.downcase }.each do |country|
    next if country.nil? || country.empty?

    country_slug = slugify(country)

    file.puts <<~MARKDOWN
      <li>
        <a href="/country/#{country_slug}/">#{country}</a>
      </li>
    MARKDOWN
  end

  file.puts "</ul>"
end

puts "Created: _country/index.md"