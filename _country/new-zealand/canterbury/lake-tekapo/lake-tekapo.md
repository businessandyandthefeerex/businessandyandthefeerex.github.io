---
layout: page
title: Lake Tekapo, Lake Tekapo, Canterbury, New Zealand
country: New Zealand
region: Canterbury
suburb: Lake Tekapo
city: Lake Tekapo
permalink: /country/new-zealand/canterbury/lake-tekapo/lake-tekapo/
---
[↑ Go to Lake Tekapo](/country/new-zealand/canterbury/lake-tekapo/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Canterbury" | where: "suburb", "Lake Tekapo" | where: "city", "Lake Tekapo" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
