---
layout: page
title: Taupō, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Taupō
permalink: /country/new-zealand/waikato/taupō/
---
[↑ Go to Waikato](/country/new-zealand/waikato/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Taupō" %}
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
