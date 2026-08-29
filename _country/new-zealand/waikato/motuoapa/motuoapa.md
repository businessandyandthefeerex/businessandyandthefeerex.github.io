---
layout: page
title: Motuoapa, Motuoapa, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Motuoapa
city: Motuoapa
permalink: /country/new-zealand/waikato/motuoapa/motuoapa/
---
[↑ Go to Motuoapa](/country/new-zealand/waikato/motuoapa/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Motuoapa" | where: "city", "Motuoapa" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
