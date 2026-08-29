---
layout: page
title: Māngere, Māngere, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Māngere
city: Māngere
permalink: /country/new-zealand/auckland/māngere/māngere/
---
[↑ Go to Māngere](/country/new-zealand/auckland/māngere/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Māngere" | where: "city", "Māngere" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
