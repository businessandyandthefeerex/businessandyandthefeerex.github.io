---
layout: page
title: Oreti, Oreti, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Oreti
city: Oreti
permalink: /country/new-zealand/waikato/oreti/oreti/
---
[↑ Go to Oreti](/country/new-zealand/waikato/oreti/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Oreti" | where: "city", "Oreti" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
