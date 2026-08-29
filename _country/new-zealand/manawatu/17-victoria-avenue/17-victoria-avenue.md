---
layout: page
title: 17 Victoria Avenue, 17 Victoria Avenue, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 17 Victoria Avenue
city: 17 Victoria Avenue
permalink: /country/new-zealand/manawatu/17-victoria-avenue/17-victoria-avenue/
---
[↑ Go to 17 Victoria Avenue](/country/new-zealand/manawatu/17-victoria-avenue/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "17 Victoria Avenue" | where: "city", "17 Victoria Avenue" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
