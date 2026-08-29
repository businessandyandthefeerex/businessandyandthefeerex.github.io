---
layout: page
title: Mount Albert, Mount Albert, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Mount Albert
city: Mount Albert
permalink: /country/new-zealand/auckland/mount-albert/mount-albert/
---
[↑ Go to Mount Albert](/country/new-zealand/auckland/mount-albert/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Mount Albert" | where: "city", "Mount Albert" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
