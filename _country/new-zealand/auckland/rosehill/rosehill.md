---
layout: page
title: Rosehill, Rosehill, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Rosehill
city: Rosehill
permalink: /country/new-zealand/auckland/rosehill/rosehill/
---
[↑ Go to Rosehill](/country/new-zealand/auckland/rosehill/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Rosehill" | where: "city", "Rosehill" %}
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
