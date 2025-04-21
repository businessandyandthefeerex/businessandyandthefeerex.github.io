require 'yaml'
require 'fileutils'
require 'date'

POSTS_DIR = "_posts"
TARGET_KEYS = %w[category rating meal]

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