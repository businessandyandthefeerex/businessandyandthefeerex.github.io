require 'yaml'
require 'fileutils'
require 'date'

POSTS_DIR = "_posts"

# Remove existing reviews directory and its contents
FileUtils.rm_rf("_reviews")
FileUtils.mkdir_p("_reviews")

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

    # Create directories for year, month, and day (e.g., _reviews/2023/01/15/)
    reviews_dir = "_reviews/#{year}/#{format('%02d', month)}/#{format('%02d', day)}"
    FileUtils.mkdir_p(reviews_dir)

    # Create index.md for the day if it doesn't exist
    day_index_file = File.join(reviews_dir, "index.md")
    unless File.exist?(day_index_file)
      File.write(day_index_file, <<~MARKDOWN)
      ---
      layout: page
      title: "Reviews from #{format('%02d', day)} #{Date::MONTHNAMES[month]} #{year}"
      permalink: /reviews/#{year}/#{format('%02d', month)}/#{format('%02d', day)}/
      year: #{year}
      month: #{format('%02d', month)}
      day: #{format('%02d', day)}
      ---
      [↑ Go to #{Date::MONTHNAMES[month]} #{year}](/reviews/#{year}/#{format('%02d', month)}/)

      {% assign this_year = page.year | plus: 0 %}
      {% assign this_month = page.month | plus: 0 %}
      {% assign this_day = page.day | plus: 0 %}
      <ul>
          {% for post in site.posts %}
              {% assign review_year = post.date | date: "%Y" | plus: 0 %}
              {% assign review_month = post.date | date: "%m" | plus: 0 %}
              {% assign review_day = post.date | date: "%d" | plus: 0 %}
              {% if review_year == this_year and review_month == this_month and review_day == this_day %}
                  <li><a href="{{ post.url }}">{{ post.title }}</a></li>
              {% endif %}
          {% endfor %}
      </ul>
    MARKDOWN


      puts "Created: #{day_index_file}"
    end

    # Create index.md for the month if it doesn't exist
    month_index_file = File.join("_reviews/#{year}/#{format('%02d', month)}", "index.md")
    unless File.exist?(month_index_file)
      File.write(month_index_file, <<~MARKDOWN)
      ---
      layout: page
      title: "Reviews from #{Date::MONTHNAMES[month]} #{year}"
      permalink: /reviews/#{year}/#{format('%02d', month)}/
      year: #{year}
      month: #{format('%02d', month)}
      ---
      [↑ Go to #{year}](/reviews/#{year}/)

      {% assign this_year = page.year | plus: 0 %}
      {% assign this_month = page.month | plus: 0 %}
      <ul>
          {% for post in site.posts %}
              {% assign review_year = post.date | date: "%Y" | plus: 0 %}
              {% assign review_month = post.date | date: "%m" | plus: 0 %}
              {% if review_year == this_year and review_month == this_month %}
                  <li><a href="{{ post.url }}">{{ post.title }}</a></li>
              {% endif %}
          {% endfor %}
      </ul>
      MARKDOWN

      puts "Created: #{month_index_file}"
    end

    # Create index.md for the year if it doesn't exist
    year_index_file = File.join("_reviews/#{year}", "index.md")
    unless File.exist?(year_index_file)
    File.write(year_index_file, <<~MARKDOWN)
        ---
        layout: page
        title: "Reviews from #{year}"
        permalink: /reviews/#{year}/
        year: #{year}
        ---
        [↑ Go to all reviews](/reviews/)

        {% assign this_year = page.year | plus: 0 %}
        {% assign sorted_posts = site.posts | sort: "date" | reverse %}
        {% assign current_month = "" %}
        {% assign first_loop = true %}

        {% for post in sorted_posts %}
        {% assign review_year = post.date | date: "%Y" | plus: 0 %}
        {% if review_year == this_year %}
        {% assign post_month = post.date | date: "%B" %}
        {% if post_month != current_month %}
        {% unless first_loop %}
        </ul>
        {% endunless %}
        <h4>{{ post_month }}</h4>
        <ul>
        {% assign current_month = post_month %}
        {% assign first_loop = false %}
        {% endif %}
        <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
        {% endfor %}
        </ul>
    MARKDOWN

    puts "Created: #{year_index_file}"
    end

  end
end

# Step 6: Create the main index page for the 'reviews' collection
reviews_index_file = File.join("_reviews", "index.md")

# Only create the index page if it doesn't already exist
unless File.exist?(reviews_index_file)
  File.write(reviews_index_file, <<~MARKDOWN)
    ---
    layout: page
    title: "All Reviews"
    permalink: /reviews/
    ---
    All our reviews, with the latest on top.

    {% assign sorted_posts = site.posts | sort: "date" | reverse %}
    {% assign current_year = "" %}
    {% assign current_month = "" %}
    {% assign first_loop = true %}

    {% for post in sorted_posts %}
    {% assign post_category = post.category %}
    {% if post_category == "Reviews" %}
    {% assign post_year = post.date | date: "%Y" %}
    {% assign post_month = post.date | date: "%B" %}

    {% if post_year != current_year %}
    {% unless first_loop %}
    </ul>
    {% endunless %}
    <h4>{{ post_year }}</h4>
    {% assign current_year = post_year %}
    {% assign current_month = "" %}
    {% endif %}

    {% if post_month != current_month %}
    {% unless first_loop or current_month == "" %}
    </ul>
    {% endunless %}
    <h5>{{ post_month }}</h5>
    <ul>
    {% assign current_month = post_month %}
    {% endif %}

    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% assign first_loop = false %}

    {% if forloop.last %}
    </ul>
    {% endif %}
    {% endif %}
    {% endfor %}

  MARKDOWN

  puts "Created: #{reviews_index_file}"
end