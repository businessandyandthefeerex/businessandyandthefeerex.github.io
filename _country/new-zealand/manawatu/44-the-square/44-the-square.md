---
layout: page
title: 44 The Square, 44 The Square, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 44 The Square
city: 44 The Square
permalink: /country/new-zealand/manawatu/44-the-square/44-the-square/
---
[↑ Go to 44 The Square](/country/new-zealand/manawatu/44-the-square/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "44 The Square" | where: "city", "44 The Square" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
  <h4>Rating: {{ group.name }}</h4>
  <ul>
    {% for post in group.items %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
