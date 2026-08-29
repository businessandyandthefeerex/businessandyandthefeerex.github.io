---
layout: page
title: Matatoki, Matatoki, Coromandel, New Zealand
country: New Zealand
region: Coromandel
suburb: Matatoki
city: Matatoki
permalink: /country/new-zealand/coromandel/matatoki/matatoki/
---
[↑ Go to Matatoki](/country/new-zealand/coromandel/matatoki/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Coromandel" | where: "suburb", "Matatoki" | where: "city", "Matatoki" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
