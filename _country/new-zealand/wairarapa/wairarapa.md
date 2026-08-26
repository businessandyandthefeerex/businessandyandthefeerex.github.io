---
layout: page
title: Wairarapa, Wairarapa, New Zealand
country: New Zealand
region: Wairarapa
suburb: Wairarapa
permalink: /country/new-zealand/wairarapa/wairarapa/
---
[↑ Go to Wairarapa](/country/new-zealand/wairarapa/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wairarapa" | where: "suburb", "Wairarapa" %}
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
