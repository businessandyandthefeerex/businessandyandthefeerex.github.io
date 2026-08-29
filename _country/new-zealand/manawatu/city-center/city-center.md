---
layout: page
title: City Center, City Center, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: City Center
city: City Center
permalink: /country/new-zealand/manawatu/city-center/city-center/
---
[↑ Go to City Center](/country/new-zealand/manawatu/city-center/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "City Center" | where: "city", "City Center" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
