---
layout: page
title: Waitomo Caves, Waitomo Caves, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Waitomo Caves
city: Waitomo Caves
permalink: /country/new-zealand/waikato/waitomo-caves/waitomo-caves/
---
[↑ Go to Waitomo Caves](/country/new-zealand/waikato/waitomo-caves/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Waitomo Caves" | where: "city", "Waitomo Caves" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
