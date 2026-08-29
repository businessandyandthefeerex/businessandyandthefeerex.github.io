---
layout: page
title: Dannevirke, Dannevirke, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Dannevirke
city: Dannevirke
permalink: /country/new-zealand/manawatu/dannevirke/dannevirke/
---
[↑ Go to Dannevirke](/country/new-zealand/manawatu/dannevirke/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Dannevirke" | where: "city", "Dannevirke" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
