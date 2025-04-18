---
title: Reviews
permalink: /reviews/
---
All our restaurant reviews, with the latest on top.

<ul>
  {% for post in site.categories.reviews %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
