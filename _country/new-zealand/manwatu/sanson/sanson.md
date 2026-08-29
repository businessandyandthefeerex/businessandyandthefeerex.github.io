---
layout: page
title: Sanson, Sanson, Manwatu, New Zealand
country: New Zealand
region: Manwatu
suburb: Sanson
city: Sanson
permalink: /country/new-zealand/manwatu/sanson/sanson/
---
[↑ Go to Sanson](/country/new-zealand/manwatu/sanson/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manwatu" | where: "suburb", "Sanson" | where: "city", "Sanson" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
