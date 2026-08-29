---
layout: page
title: Taihape, Taihape, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Taihape
city: Taihape
permalink: /country/new-zealand/manawatu/taihape/taihape/
---
[↑ Go to Taihape](/country/new-zealand/manawatu/taihape/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Taihape" | where: "city", "Taihape" %}
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
