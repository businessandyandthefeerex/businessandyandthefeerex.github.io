#!/usr/bin/env ruby

require 'yaml'
require 'date'

# Helper to find the meal description line in body
def find_meal_in_body(body)
  body.each_line do |line|
    if line =~ /\bwe ate (lunch|dinner) here in\b/i
      return Regexp.last_match(1).downcase
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

    if front_matter['meal'] == 'lunch'
      meal_in_body = find_meal_in_body(body)

      if meal_in_body == 'dinner' || meal_in_body.nil?
        front_matter['meal'] = 'dinner'

        # Rebuild file
        new_content = "---\n" + front_matter.to_yaml + "---\n" + body

        File.write(filename, new_content)

        puts "Updated #{filename}: meal changed to dinner"
      else
        puts "Checked #{filename}: meal remains lunch"
      end
    else
      puts "Skipped #{filename}: meal not lunch"
    end
  else
    puts "Skipped #{filename}: no front matter found"
  end
end
