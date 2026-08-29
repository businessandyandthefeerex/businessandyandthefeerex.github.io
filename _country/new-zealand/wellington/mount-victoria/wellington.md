---
layout: page
title: Wellington, Mount Victoria, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Mount Victoria
city: Wellington
permalink: /country/new-zealand/wellington/mount-victoria/wellington/
---
[↑ Go to Mount Victoria](/country/new-zealand/wellington/mount-victoria/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Mount Victoria" | where: "city", "Wellington" %}
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
