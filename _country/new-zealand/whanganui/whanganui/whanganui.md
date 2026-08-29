---
layout: page
title: Whanganui, Whanganui, Whanganui, New Zealand
country: New Zealand
region: Whanganui
suburb: Whanganui
city: Whanganui
permalink: /country/new-zealand/whanganui/whanganui/whanganui/
---
[↑ Go to Whanganui](/country/new-zealand/whanganui/whanganui/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Whanganui" | where: "suburb", "Whanganui" | where: "city", "Whanganui" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
