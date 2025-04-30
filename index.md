---
title: Business Andy & The Fee-Rex
---
<h4>Restaurant Reviews</h4>
<img id="featured-image" src="" alt="Featured Image" />
<h4>The Restaurant Rating System</h4>
4 - Great  
3 - Good  
2 - Meh  
1 - Bad  
<h4>The Restaurant Selection System</h4>
Restaurants are usually selected either using a random number generator or on an eat-at-the-first-place-we-see basis.
<h4>Latest Reviews</h4>
<ul>
    {% for post in site.posts limit:5 %}
        <li>
            <a href="{{ post.url }}">{{ post.title }}</a>
            {% if post.date and post.rating %}
                <div class="meta-info">
                    <span class="date" style="font-style: italic; color: #a8adac; font-size: 0.9em;">
                        {{ post.date | date: "%-d %B %Y" }}, Rating: {{ post.rating }}
                    </span>
                </div>
            {% endif %}
        </li>
    {% endfor %}
</ul>

<script type="text/javascript">
  // Array of image URLs relative to the assets folder
  const images = [
    "{{ '/assets/images/page_art_01.png' | relative_url }}", 
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
