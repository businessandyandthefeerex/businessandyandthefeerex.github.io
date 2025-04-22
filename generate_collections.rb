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
      collection_data[key] << value.to_s # Ensure everything is treated as a string
    end
  end
end

# Step 2: Create collection directories and index pages for each collection
collection_data.each do |key, values|
  dir = "_#{key}"

  # Remove existing collection directory and all its contents (if it exists)
  if File.exist?(dir)
    FileUtils.rm_rf(dir)
  end

  # Create the base directory for the collection
  FileUtils.mkdir_p(dir)

  # Create index.md for the collection itself
  index_file = File.join(dir, "index.md")
  File.write(index_file, <<~MARKDOWN)
  ---
  layout: page
  title: "#{key.capitalize} Collection"
  permalink: /#{key}/
  ---

  Every value used for the #{key} collection.

  <ul>
    {% assign current_key = "#{key}" %}
    {% assign is_numeric = current_key == "rating" %}
    {% assign all_values = site.posts | map: current_key | uniq %}
    {% if is_numeric %}
      {% assign all_values = all_values | sort | reverse %}
    {% else %}
      {% assign all_values = all_values | sort %}
    {% endif %}

    {% for value in all_values %}
      {% assign slug = value | append: "" | slugify %}
      <li>
        <a href="/#{key}/{{ slug }}/">
          {{ current_key | capitalize }}: {{ value | capitalize }}
        </a>
      </li>
    {% endfor %}
  </ul>
  MARKDOWN

  puts "Created index: #{index_file}"

# Step 3: Create pages for each value within the collection
values.each do |value|
  slug = slugify(value.to_s)
  file_path = File.join(dir, "#{slug}.md")

  # Remove the file if it already exists before creating it again
  if File.exist?(file_path)
    FileUtils.rm_f(file_path)
  end

  File.write(file_path, <<~MARKDOWN)
  ---
  layout: page
  title: "#{key.capitalize}: #{value.capitalize}"
  #{key}: "#{value}"
  ---
  [↑ Go to the #{key.capitalize} collection](/#{key}/)

  Every post with the value #{value} for the #{key} collection.

  <ul>
    {% assign current_key = "#{key}" %}
    {% assign current_value = page[current_key] | append: "" %}
    {% assign matching_posts = site.posts | where: current_key, current_value | sort: "title" %}

    {% for post in matching_posts %}
        <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
  MARKDOWN

  puts "Created: #{file_path}"
  end

end