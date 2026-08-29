---
layout: page
title: Levin, Levin, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Levin
city: Levin
permalink: /country/new-zealand/manawatu/levin/levin/
---
[↑ Go to Levin](/country/new-zealand/manawatu/levin/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Levin" | where: "city", "Levin" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
