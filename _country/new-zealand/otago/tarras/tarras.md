---
layout: page
title: Tarras, Tarras, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Tarras
city: Tarras
permalink: /country/new-zealand/otago/tarras/tarras/
---
[↑ Go to Tarras](/country/new-zealand/otago/tarras/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Tarras" | where: "city", "Tarras" %}
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
