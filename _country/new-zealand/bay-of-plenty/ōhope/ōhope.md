---
layout: page
title: Ōhope, Ōhope, Bay of Plenty, New Zealand
country: New Zealand
region: Bay of Plenty
suburb: Ōhope
city: Ōhope
permalink: /country/new-zealand/bay-of-plenty/ōhope/ōhope/
---
[↑ Go to Ōhope](/country/new-zealand/bay-of-plenty/ōhope/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Bay of Plenty" | where: "suburb", "Ōhope" | where: "city", "Ōhope" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
