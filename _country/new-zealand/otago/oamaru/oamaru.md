---
layout: page
title: Oamaru, Oamaru, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Oamaru
city: Oamaru
permalink: /country/new-zealand/otago/oamaru/oamaru/
---
[↑ Go to Oamaru](/country/new-zealand/otago/oamaru/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Oamaru" | where: "city", "Oamaru" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
