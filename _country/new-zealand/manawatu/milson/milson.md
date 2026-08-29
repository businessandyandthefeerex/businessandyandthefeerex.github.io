---
layout: page
title: Milson, Milson, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Milson
city: Milson
permalink: /country/new-zealand/manawatu/milson/milson/
---
[↑ Go to Milson](/country/new-zealand/manawatu/milson/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Milson" | where: "city", "Milson" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
