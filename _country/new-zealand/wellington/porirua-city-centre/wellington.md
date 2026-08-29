---
layout: page
title: Wellington, Porirua City Centre, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Porirua City Centre
city: Wellington
permalink: /country/new-zealand/wellington/porirua-city-centre/wellington/
---
[↑ Go to Porirua City Centre](/country/new-zealand/wellington/porirua-city-centre/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Porirua City Centre" | where: "city", "Wellington" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
