---
layout: page
title: Tūrangi, Tūrangi, Waikato, New Zealand
country: New Zealand
region: Waikato
suburb: Tūrangi
city: Tūrangi
permalink: /country/new-zealand/waikato/tūrangi/tūrangi/
---
[↑ Go to Tūrangi](/country/new-zealand/waikato/tūrangi/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waikato" | where: "suburb", "Tūrangi" | where: "city", "Tūrangi" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
