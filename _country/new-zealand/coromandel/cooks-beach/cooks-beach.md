---
layout: page
title: Cooks Beach, Cooks Beach, Coromandel, New Zealand
country: New Zealand
region: Coromandel
suburb: Cooks Beach
city: Cooks Beach
permalink: /country/new-zealand/coromandel/cooks-beach/cooks-beach/
---
[↑ Go to Cooks Beach](/country/new-zealand/coromandel/cooks-beach/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Coromandel" | where: "suburb", "Cooks Beach" | where: "city", "Cooks Beach" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
