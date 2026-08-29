---
layout: page
title: Napier, Napier, Hawkes Bay, New Zealand
country: New Zealand
region: Hawkes Bay
suburb: Napier
city: Napier
permalink: /country/new-zealand/hawkes-bay/napier/napier/
---
[↑ Go to Napier](/country/new-zealand/hawkes-bay/napier/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Hawkes Bay" | where: "suburb", "Napier" | where: "city", "Napier" %}
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
