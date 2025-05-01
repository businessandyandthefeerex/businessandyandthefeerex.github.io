---
layout: page
title: Auckland City Centre, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Auckland City Centre
permalink: /country/new-zealand/auckland/auckland-city-centre/
---
[↑ Go to Auckland](/country/new-zealand/auckland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Auckland City Centre" %}
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
