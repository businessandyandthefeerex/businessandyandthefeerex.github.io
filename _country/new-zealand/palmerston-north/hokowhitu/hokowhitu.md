---
layout: page
title: Hokowhitu, Hokowhitu, Palmerston North, New Zealand
country: New Zealand
region: Palmerston North
suburb: Hokowhitu
city: Hokowhitu
permalink: /country/new-zealand/palmerston-north/hokowhitu/hokowhitu/
---
[↑ Go to Hokowhitu](/country/new-zealand/palmerston-north/hokowhitu/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Palmerston North" | where: "suburb", "Hokowhitu" | where: "city", "Hokowhitu" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
