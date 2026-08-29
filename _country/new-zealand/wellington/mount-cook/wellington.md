---
layout: page
title: Wellington, Mount Cook, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Mount Cook
city: Wellington
permalink: /country/new-zealand/wellington/mount-cook/wellington/
---
[↑ Go to Mount Cook](/country/new-zealand/wellington/mount-cook/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Mount Cook" | where: "city", "Wellington" %}
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
