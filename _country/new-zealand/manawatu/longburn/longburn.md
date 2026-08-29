---
layout: page
title: Longburn, Longburn, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Longburn
city: Longburn
permalink: /country/new-zealand/manawatu/longburn/longburn/
---
[↑ Go to Longburn](/country/new-zealand/manawatu/longburn/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Longburn" | where: "city", "Longburn" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
