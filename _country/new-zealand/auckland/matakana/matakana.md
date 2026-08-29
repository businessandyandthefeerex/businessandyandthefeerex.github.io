---
layout: page
title: Matakana, Matakana, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Matakana
city: Matakana
permalink: /country/new-zealand/auckland/matakana/matakana/
---
[↑ Go to Matakana](/country/new-zealand/auckland/matakana/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Matakana" | where: "city", "Matakana" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
