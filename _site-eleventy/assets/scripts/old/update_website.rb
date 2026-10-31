#!/usr/bin/env ruby

require 'yaml'
require 'date'

# Helper to find website or "has no website" in body
def find_website_in_body(body)
  body.each_line do |line|
    downcased_line = line.downcase
    return :no_website if downcased_line.include?("has no website")

    if line =~ %r{\b(https?://\S+|www\.\S+)}i
      return Regexp.last_match(1)
    end
  end
  nil
end

# Process each markdown file in the same directory
Dir.glob("*.md") do |filename|
  content = File.read(filename)

  # Split front matter and body
  if content =~ /\A---\s*\n(.*?)\n---\s*\n(.*)/m
    front_matter_raw = $1
    body = $2

    front_matter = YAML.safe_load(front_matter_raw, permitted_classes: [Date])

    if front_matter.key?('website')
      website_in_body = find_website_in_body(body)

      if website_in_body == :no_website || website_in_body.nil?
        front_matter['website'] = nil
        puts "Updated #{filename}: website cleared"
      else
        front_matter['website'] = website_in_body
        puts "Updated #{filename}: website set to #{website_in_body}"
      end

      # Rebuild file
      new_content = "---\n" + front_matter.to_yaml + "---\n" + body
      File.write(filename, new_content)
    else
      puts "Skipped #{filename}: no website field in front matter"
    end
  else
    puts "Skipped #{filename}: no front matter found"
  end
end
