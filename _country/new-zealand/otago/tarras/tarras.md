---
layout: page
title: Tarras, Tarras, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Tarras
city: Tarras
permalink: /country/new-zealand/otago/tarras/tarras/
---
[↑ Go to Tarras](/country/new-zealand/otago/tarras/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Tarras" | where: "city", "Tarras" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
