---
layout: page
title: Wellington, Petone, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Petone
city: Wellington
permalink: /country/new-zealand/wellington/petone/wellington/
---
[↑ Go to Petone](/country/new-zealand/wellington/petone/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Petone" | where: "city", "Wellington" %}
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
