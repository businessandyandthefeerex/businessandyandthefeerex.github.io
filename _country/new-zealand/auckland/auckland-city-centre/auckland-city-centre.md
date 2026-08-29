---
layout: page
title: Auckland City Centre, Auckland City Centre, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Auckland City Centre
city: Auckland City Centre
permalink: /country/new-zealand/auckland/auckland-city-centre/auckland-city-centre/
---
[↑ Go to Auckland City Centre](/country/new-zealand/auckland/auckland-city-centre/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Auckland City Centre" | where: "city", "Auckland City Centre" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
