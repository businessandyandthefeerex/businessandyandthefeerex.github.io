---
layout: page
title: Paihia, Paihia, Northland, New Zealand
country: New Zealand
region: Northland
suburb: Paihia
city: Paihia
permalink: /country/new-zealand/northland/paihia/paihia/
---
[↑ Go to Paihia](/country/new-zealand/northland/paihia/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Northland" | where: "suburb", "Paihia" | where: "city", "Paihia" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
