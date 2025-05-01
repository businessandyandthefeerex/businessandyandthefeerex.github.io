---
layout: page
title: Paihia, Northland, New Zealand
country: New Zealand
region: Northland
suburb: Paihia
permalink: /country/new-zealand/northland/paihia/
---
[↑ Go to Northland](/country/new-zealand/northland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Northland" | where: "suburb", "Paihia" %}
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
