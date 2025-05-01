require 'jekyll'
require 'fileutils'

config = Jekyll.configuration({})
site = Jekyll::Site.new(config)
site.read

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

countries = site.posts.docs.map { |post| post.data['country'] }.uniq

countries.each do |country|
  next if country.nil? || country.empty?

  country_slug = country.downcase.gsub(" ", "-")
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

    country_posts = site.posts.docs.select { |post| post.data['country'] == country }
    grouped_by_region = country_posts.group_by { |post| post.data['region'] }

    grouped_by_region
      .sort_by { |region, _| region.downcase }
      .each do |region, region_posts|

      next if region.nil? || region.empty?

      region_slug = region.downcase.gsub(" ", "-")

      file.puts <<~MARKDOWN
        <li>
          <a href="/country/#{country_slug}/#{region_slug}/">#{region}</a>
        </li>
      MARKDOWN

      region_filename = "#{country_folder}/#{region_slug}.md"

      File.open(region_filename, "w") do |region_file|
        region_file.puts <<~MARKDOWN
          ---
          layout: page
          title: #{region}, #{country}
          country: #{country}
          region: #{region}
          permalink: /country/#{country_slug}/#{region_slug}/
          ---
          [↑ Go to #{country} regions](/country/#{country_slug}/)
          <ul>
            {% assign posts = site.posts | where: "region", "#{region}" | where: "country", "#{country}" %}
            {% assign grouped_posts = posts | group_by: "suburb" %}

            {% assign sorted_grouped_posts = grouped_posts | sort: "name" %}
            {% for group in sorted_grouped_posts %}

              {% assign suburb_slug = group.name | downcase | slugify %}
              <h4><a href="/country/#{country_slug}/#{region_slug}/{{ suburb_slug }}" style="color: var(--heading-color);">{{ group.name }}</a></h4>

              {% assign rating_groups = group.items | group_by: "rating" %}
              {% assign sorted_rating_groups = rating_groups | sort: "name" %}

              {% for rating_group in sorted_rating_groups reversed %}
                <h5>Rating: {{ rating_group.name }}</h5>
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
      puts "Created: _country/#{country_slug}/#{region_slug}/"

      # Create suburb pages
      suburb_groups = region_posts.group_by { |post| post.data['suburb'] }

      suburb_groups.each do |suburb, suburb_posts|
        next if suburb.nil? || suburb.empty?

        suburb_slug = suburb.downcase.gsub(" ", "-")
        suburb_folder = "#{country_folder}/#{region_slug}"
        suburb_filename = "#{suburb_folder}/#{suburb_slug}.md"

        FileUtils.mkdir_p(suburb_folder) unless File.exist?(suburb_folder)

        File.open(suburb_filename, "w") do |suburb_file|
          suburb_file.puts <<~MARKDOWN
            ---
            layout: page
            title: #{suburb}, #{region}, #{country}
            country: #{country}
            region: #{region}
            suburb: #{suburb}
            permalink: /country/#{country_slug}/#{region_slug}/#{suburb_slug}/
            ---
            [↑ Go to #{region}](/country/#{country_slug}/#{region_slug}/)

            {% assign posts = site.posts | where: "country", "#{country}" | where: "region", "#{region}" | where: "suburb", "#{suburb}" %}
            {% assign grouped_posts = posts | group_by: "rating" %}
            {% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

            {% for group in sorted_grouped_posts reversed %}
              <h4>Rating: {{ group.name }}</h4>
              <ul>
                {% for post in group.items %}
                  <li><a href="{{ post.url }}">{{ post.title }}</a></li>
                {% endfor %}
              </ul>
            {% endfor %}
          MARKDOWN
        end

        puts "Created: _country/#{country_slug}/#{region_slug}/#{suburb_slug}/"
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

    country_slug = country.downcase.gsub(" ", "-")

    file.puts <<~MARKDOWN
      <li>
        <a href="/country/#{country_slug}/">#{country}</a>
      </li>
    MARKDOWN
  end

  file.puts "</ul>"
end

puts "Created: _country/index.md"