---
layout: page
title: Central, Central, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Central
city: Central
permalink: /country/new-zealand/manawatu/central/central/
---
[↑ Go to Central](/country/new-zealand/manawatu/central/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Central" | where: "city", "Central" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
