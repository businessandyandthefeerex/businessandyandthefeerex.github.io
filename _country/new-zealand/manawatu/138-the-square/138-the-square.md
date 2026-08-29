---
layout: page
title: 138 The Square, 138 The Square, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 138 The Square
city: 138 The Square
permalink: /country/new-zealand/manawatu/138-the-square/138-the-square/
---
[↑ Go to 138 The Square](/country/new-zealand/manawatu/138-the-square/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "138 The Square" | where: "city", "138 The Square" %}
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
