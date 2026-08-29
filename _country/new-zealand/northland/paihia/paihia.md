---
layout: page
title: Paihia, Paihia, Northland, New Zealand
country: New Zealand
region: Northland
suburb: Paihia
city: Paihia
permalink: /country/new-zealand/northland/paihia/paihia/
---
[↑ Go to Paihia](/country/new-zealand/northland/paihia/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Northland" | where: "suburb", "Paihia" | where: "city", "Paihia" %}
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
