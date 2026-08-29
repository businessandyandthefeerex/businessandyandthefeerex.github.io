---
layout: page
title: Mount Victoria, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Mount Victoria
permalink: /country/new-zealand/wellington/mount-victoria/
---
[↑ Go to Wellington](/country/new-zealand/wellington/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Mount Victoria" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
