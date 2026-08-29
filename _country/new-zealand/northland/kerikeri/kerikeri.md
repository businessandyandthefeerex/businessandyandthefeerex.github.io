---
layout: page
title: Kerikeri, Kerikeri, Northland, New Zealand
country: New Zealand
region: Northland
suburb: Kerikeri
city: Kerikeri
permalink: /country/new-zealand/northland/kerikeri/kerikeri/
---
[↑ Go to Kerikeri](/country/new-zealand/northland/kerikeri/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Northland" | where: "suburb", "Kerikeri" | where: "city", "Kerikeri" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
