---
layout: page
title: Manukau City Centre, Manukau City Centre, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Manukau City Centre
city: Manukau City Centre
permalink: /country/new-zealand/auckland/manukau-city-centre/manukau-city-centre/
---
[↑ Go to Manukau City Centre](/country/new-zealand/auckland/manukau-city-centre/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Manukau City Centre" | where: "city", "Manukau City Centre" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
