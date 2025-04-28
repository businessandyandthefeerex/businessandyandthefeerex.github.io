---
title: Business Andy & The Fee-Rex
---
<img id="featured-image" src="" alt="Featured Image" />

This is just a place for us to keep our restaurant reviews.  
  
Navigation is up top and the latest reviews are right below this text. If you are looking for a specific review then either try one of the browse pages in the header, or try searching.


<h4>Latest Reviews</h4>
<ul>
    {% for post in site.posts limit:5 %}
        <li>
            <a href="{{ post.url }}">{{ post.title }}</a>
            {% if post.date or post.rating %}
                <div class="meta-info">
                    {% if post.date %}
                        <span class="date" style="font-style: italic; color: #a8adac; font-size: 0.9em;">
                            {{ post.date | date: "%-d %B %Y" }},
                        </span>
                    {% endif %}
                    {% if post.date and post.rating %}
                        &nbsp;
                    {% endif %}
                    {% if post.rating %}
                        <span class="rating" style="font-style: italic; color: #a8adac; font-size: 0.9em;">
                            Rating: {{ post.rating }}
                        </span>
                    {% endif %}
                </div>
            {% endif %}
        </li>
    {% endfor %}
</ul>

<script type="text/javascript">
  // Array of image URLs relative to the assets folder
  const images = [
    "{{ '/assets/images/page_art_01.png' | relative_url }}",  // Adjust the paths according to your images
    "{{ '/assets/images/page_art_02.png' | relative_url }}",
    "{{ '/assets/images/page_art_03.png' | relative_url }}"
  ];

  // Function to randomly select an image and set it as the source of the image element
  function setRandomImage() {
    const randomIndex = Math.floor(Math.random() * images.length);
    const featuredImage = document.getElementById('featured-image');
    featuredImage.src = images[randomIndex];
  }

  // Set a random image when the page loads
  window.onload = setRandomImage;
</script>
