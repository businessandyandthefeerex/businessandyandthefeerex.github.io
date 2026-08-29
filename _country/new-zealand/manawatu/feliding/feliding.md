---
layout: page
title: Feliding, Feliding, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Feliding
city: Feliding
permalink: /country/new-zealand/manawatu/feliding/feliding/
---
[↑ Go to Feliding](/country/new-zealand/manawatu/feliding/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Feliding" | where: "city", "Feliding" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
