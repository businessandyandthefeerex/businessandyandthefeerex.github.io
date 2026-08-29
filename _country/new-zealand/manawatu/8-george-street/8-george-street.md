---
layout: page
title: 8 George Street, 8 George Street, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 8 George Street
city: 8 George Street
permalink: /country/new-zealand/manawatu/8-george-street/8-george-street/
---
[↑ Go to 8 George Street](/country/new-zealand/manawatu/8-george-street/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "8 George Street" | where: "city", "8 George Street" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
