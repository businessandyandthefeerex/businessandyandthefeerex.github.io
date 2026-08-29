---
layout: page
title: Hokowhitu, Hokowhitu, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Hokowhitu
city: Hokowhitu
permalink: /country/new-zealand/manawatu/hokowhitu/hokowhitu/
---
[↑ Go to Hokowhitu](/country/new-zealand/manawatu/hokowhitu/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Hokowhitu" | where: "city", "Hokowhitu" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
