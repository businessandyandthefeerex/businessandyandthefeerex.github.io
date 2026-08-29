---
layout: page
title: Kingsland, Kingsland, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Kingsland
city: Kingsland
permalink: /country/new-zealand/auckland/kingsland/kingsland/
---
[↑ Go to Kingsland](/country/new-zealand/auckland/kingsland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Kingsland" | where: "city", "Kingsland" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
