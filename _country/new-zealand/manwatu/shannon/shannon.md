---
layout: page
title: Shannon, Shannon, Manwatu, New Zealand
country: New Zealand
region: Manwatu
suburb: Shannon
city: Shannon
permalink: /country/new-zealand/manwatu/shannon/shannon/
---
[↑ Go to Shannon](/country/new-zealand/manwatu/shannon/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manwatu" | where: "suburb", "Shannon" | where: "city", "Shannon" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
