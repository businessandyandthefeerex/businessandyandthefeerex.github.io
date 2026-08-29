---
layout: page
title: Palmerston North Central, Palmerston North Central, Palmerston North, New Zealand
country: New Zealand
region: Palmerston North
suburb: Palmerston North Central
city: Palmerston North Central
permalink: /country/new-zealand/palmerston-north/palmerston-north-central/palmerston-north-central/
---
[↑ Go to Palmerston North Central](/country/new-zealand/palmerston-north/palmerston-north-central/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Palmerston North" | where: "suburb", "Palmerston North Central" | where: "city", "Palmerston North Central" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
