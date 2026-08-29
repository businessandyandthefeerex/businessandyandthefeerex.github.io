---
layout: page
title: Wairarapa, Wairarapa, Wairarapa, New Zealand
country: New Zealand
region: Wairarapa
suburb: Wairarapa
city: Wairarapa
permalink: /country/new-zealand/wairarapa/wairarapa/wairarapa/
---
[↑ Go to Wairarapa](/country/new-zealand/wairarapa/wairarapa/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wairarapa" | where: "suburb", "Wairarapa" | where: "city", "Wairarapa" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
