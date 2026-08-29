---
layout: page
title: Wellington, Churton Park, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Churton Park
city: Wellington
permalink: /country/new-zealand/wellington/churton-park/wellington/
---
[↑ Go to Churton Park](/country/new-zealand/wellington/churton-park/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Churton Park" | where: "city", "Wellington" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
