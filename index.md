---
title: Business Andy and The Fee-Rex
feature_image: "https://picsum.photos/1300/400?image=989"
---

This is just a place for us to keep our restaurant reviews.  
  
Navigation is up top and the latest reviews are right below this text. If you are looking for a specific review then either try one of the browse pages in the header, or try searching.

<h4>Latest Reviews</h4>
<ul>
    {% for post in site.posts limit:5 %}
        <li>
            <a href="{{ post.url }}">{{ post.title }}</a>
            {% if post.date or post.rating %}
                <span style="font-style: italic; color: #a8adac; font-size: 0.9em; margin-left: 6px;">
                {% if post.date %}
                    {{ post.date | date: "%-d %B %Y" }},
                {% endif %}
                {% if post.date and post.rating %}
                    &nbsp;
                {% endif %}
                {% if post.rating %}
                    Rating: {{ post.rating }}
                {% endif %}
                </span>
            {% endif %}
        </li>
    {% endfor %}
</ul>