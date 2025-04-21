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
    title: "#{key.capitalize} Index"
    permalink: /#{key}/
    ---

    Every value used for the #{key} collection.

    <ul>
      {% assign all_values = site.#{key} | sort: "title" %}
      {% for item in all_values %}
        {% unless item.url == page.url %}
          {% assign title_str = item.title | append: "" %}
          <li>
            <a href="{{ item.url }}">
              {% if title_str != "" %}
                {% if title_str contains ' ' %}
                  {{ title_str | split: ' ' | map: 'capitalize' | join: ' ' }}
                {% else %}
                  {{ title_str | capitalize }}
                {% endif %}
              {% else %}
                (No title)
              {% endif %}
            </a>
          </li>
        {% endunless %}
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
  title: "#{value}"
  #{key}: "#{value}"
  ---
  [↑ Go to the #{key.capitalize} index](/#{key}/)

  Every post with a #{value} for its #{key}.

  <ul>
    {% assign current_key = "#{key}" %}
    {% assign current_value = page[current_key] | append: "" %}

    {% for post in site.posts %}
        {% assign post_value = post[current_key] | append: "" %}
        {% if post_value == current_value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
  </ul>
  MARKDOWN

  puts "Created: #{file_path}"
  end


end