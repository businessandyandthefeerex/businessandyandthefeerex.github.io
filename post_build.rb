require 'yaml'
require 'fileutils'
require 'date'
require 'set'

POSTS_DIR = "_posts"

# Create index pages for year, month, and day within the 'reviews' collection
Dir.glob("#{POSTS_DIR}/*.md").each do |post_file|
  content = File.read(post_file)
  if content =~ /\A---\s*\n(.*?)\n?---\s*\n/m
    front_matter = YAML.safe_load($1, permitted_classes: [Date])

    # Check if the 'date' field exists before proceeding
    post_date = front_matter["date"]
    next unless post_date # Skip this post if it doesn't have a 'date' field

    # Get year, month, and day from the post's date
    year = post_date.year
    month = post_date.month
    day = post_date.day

    # Create directories for year, month, and day (e.g., _site/reviews/2023/01/15/)
    reviews_dir = "_site/reviews/#{year}/#{format('%02d', month)}/#{format('%02d', day)}"
    FileUtils.mkdir_p(reviews_dir)

    # Create index.md for the day if it doesn't exist
    day_index_file = File.join(reviews_dir, "index.md")
    unless File.exist?(day_index_file)
      File.write(day_index_file, <<~MARKDOWN)
        ---
        layout: page
        title: "Reviews from #{year}-#{format('%02d', month)}-#{format('%02d', day)}"
        permalink: /reviews/#{year}/#{format('%02d', month)}/#{format('%02d', day)}/
        ---

        <h2>Reviews from #{year}-#{format('%02d', month)}-#{format('%02d', day)}</h2>

        <ul>
            {% for post in site.posts %}
                {% if post.date | date: "%Y-%m-%d" == "#{year}-#{format('%02d', month)}-#{format('%02d', day)}" %}
                    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
                {% endif %}
            {% endfor %}
        </ul>
      MARKDOWN

      puts "Created: #{day_index_file}"
    end

    # Create index.md for the month if it doesn't exist
    month_index_file = File.join("_site/reviews/#{year}/#{format('%02d', month)}", "index.md")
    unless File.exist?(month_index_file)
      File.write(month_index_file, <<~MARKDOWN)
        ---
        layout: page
        title: "Reviews from #{year}-#{format('%02d', month)}"
        permalink: /reviews/#{year}/#{format('%02d', month)}/
        ---

        <h2>Reviews from #{year}-#{format('%02d', month)}</h2>

        <ul>
            {% for post in site.posts %}
                {% if post.date | date: "%Y-%m" == "#{year}-#{format('%02d', month)}" %}
                    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
                {% endif %}
            {% endfor %}
        </ul>
      MARKDOWN

      puts "Created: #{month_index_file}"
    end

    # Create index.md for the year if it doesn't exist
    year_index_file = File.join("_site/reviews/#{year}", "index.md")
    unless File.exist?(year_index_file)
      File.write(year_index_file, <<~MARKDOWN)
        ---
        layout: page
        title: "Reviews from #{year}"
        permalink: /reviews/#{year}/
        ---

        <h2>Reviews from #{year}</h2>

        <ul>
            {% for post in site.posts %}
                {% if post.date | date: "%Y" == "#{year}" %}
                    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
                {% endif %}
            {% endfor %}
        </ul>
      MARKDOWN

      puts "Created: #{year_index_file}"
    end
  end
end

# Create the main index page for the 'reviews' collection
reviews_index_file = File.join("_site/reviews", "index.md")

# Only create the index page if it doesn't already exist
unless File.exist?(reviews_index_file)
  File.write(reviews_index_file, <<~MARKDOWN)
    ---
    layout: page
    title: "All Reviews"
    permalink: /reviews/
    ---

    <h2>All Reviews</h2>

    <ul>
        {% for post in site.posts %}
            {% if post.category == "review" %}
                <li><a href="{{ post.url }}">{{ post.title }}</a></li>
            {% endif %}
        {% endfor %}
    </ul>
  MARKDOWN

  puts "Created: #{reviews_index_file}"
end
