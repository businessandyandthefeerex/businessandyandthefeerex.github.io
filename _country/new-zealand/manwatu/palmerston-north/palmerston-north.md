---
layout: page
title: Palmerston North, Palmerston North, Manwatu, New Zealand
country: New Zealand
region: Manwatu
suburb: Palmerston North
city: Palmerston North
permalink: /country/new-zealand/manwatu/palmerston-north/palmerston-north/
---
[↑ Go to Palmerston North](/country/new-zealand/manwatu/palmerston-north/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manwatu" | where: "suburb", "Palmerston North" | where: "city", "Palmerston North" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
