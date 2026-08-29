---
layout: page
title: West End, West End, Palmerston North, New Zealand
country: New Zealand
region: Palmerston North
suburb: West End
city: West End
permalink: /country/new-zealand/palmerston-north/west-end/west-end/
---
[↑ Go to West End](/country/new-zealand/palmerston-north/west-end/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Palmerston North" | where: "suburb", "West End" | where: "city", "West End" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
