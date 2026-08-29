---
layout: page
title: Highburh, Highburh, Palmerston North, New Zealand
country: New Zealand
region: Palmerston North
suburb: Highburh
city: Highburh
permalink: /country/new-zealand/palmerston-north/highburh/highburh/
---
[↑ Go to Highburh](/country/new-zealand/palmerston-north/highburh/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Palmerston North" | where: "suburb", "Highburh" | where: "city", "Highburh" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
