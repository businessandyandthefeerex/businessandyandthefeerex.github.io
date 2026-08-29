---
layout: page
title: Takaro, Takaro, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Takaro
city: Takaro
permalink: /country/new-zealand/manawatu/takaro/takaro/
---
[↑ Go to Takaro](/country/new-zealand/manawatu/takaro/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Takaro" | where: "city", "Takaro" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
