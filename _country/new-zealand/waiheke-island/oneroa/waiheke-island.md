---
layout: page
title: Waiheke Island, Oneroa, Waiheke Island, New Zealand
country: New Zealand
region: Waiheke Island
suburb: Oneroa
city: Waiheke Island
permalink: /country/new-zealand/waiheke-island/oneroa/waiheke-island/
---
[↑ Go to Oneroa](/country/new-zealand/waiheke-island/oneroa/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waiheke Island" | where: "suburb", "Oneroa" | where: "city", "Waiheke Island" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
