---
layout: page
title: Wellington, Island Bay, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Island Bay
city: Wellington
permalink: /country/new-zealand/wellington/island-bay/wellington/
---
[↑ Go to Island Bay](/country/new-zealand/wellington/island-bay/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Island Bay" | where: "city", "Wellington" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
