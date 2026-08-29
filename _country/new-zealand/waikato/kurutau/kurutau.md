---
layout: page
title: Kurutau, Kurutau, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Kurutau
city: Kurutau
permalink: /country/new-zealand/waikato/kurutau/kurutau/
---
[↑ Go to Kurutau](/country/new-zealand/waikato/kurutau/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Kurutau" | where: "city", "Kurutau" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
