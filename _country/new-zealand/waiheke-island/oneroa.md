---
layout: page
title: Oneroa, Waiheke Island, New Zealand
country: New Zealand
region: Waiheke Island
suburb: Oneroa
permalink: /country/new-zealand/waiheke-island/oneroa/
---
[↑ Go to Waiheke Island](/country/new-zealand/waiheke-island/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waiheke Island" | where: "suburb", "Oneroa" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
