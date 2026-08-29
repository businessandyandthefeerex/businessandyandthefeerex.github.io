---
layout: page
title: Exmouth, Exmouth, Western Australia, Australia
country: Australia
region: Western Australia
suburb: Exmouth
city: Exmouth
permalink: /country/australia/western-australia/exmouth/exmouth/
---
[↑ Go to Exmouth](/country/australia/western-australia/exmouth/)

{% assign posts = site.posts | where: "country", "Australia" | where: "region", "Western Australia" | where: "suburb", "Exmouth" | where: "city", "Exmouth" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
