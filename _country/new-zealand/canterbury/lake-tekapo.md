---
layout: page
title: Lake Tekapo, Canterbury, New Zealand
country: New Zealand
region: Canterbury
suburb: Lake Tekapo
permalink: /country/new-zealand/canterbury/lake-tekapo/
---
[↑ Go to Canterbury](/country/new-zealand/canterbury/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Canterbury" | where: "suburb", "Lake Tekapo" %}
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
