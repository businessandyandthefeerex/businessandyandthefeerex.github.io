---
layout: page
title: Waiouru, Waiouru, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Waiouru
city: Waiouru
permalink: /country/new-zealand/manawatu/waiouru/waiouru/
---
[↑ Go to Waiouru](/country/new-zealand/manawatu/waiouru/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Waiouru" | where: "city", "Waiouru" %}
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
