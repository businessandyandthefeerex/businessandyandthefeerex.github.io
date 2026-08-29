---
layout: page
title: Whitianga, Whitianga, Coromandel, New Zealand
country: New Zealand
region: Coromandel
suburb: Whitianga
city: Whitianga
permalink: /country/new-zealand/coromandel/whitianga/whitianga/
---
[↑ Go to Whitianga](/country/new-zealand/coromandel/whitianga/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Coromandel" | where: "suburb", "Whitianga" | where: "city", "Whitianga" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
