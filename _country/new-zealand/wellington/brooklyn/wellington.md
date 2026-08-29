---
layout: page
title: Wellington, Brooklyn, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Brooklyn
city: Wellington
permalink: /country/new-zealand/wellington/brooklyn/wellington/
---
[↑ Go to Brooklyn](/country/new-zealand/wellington/brooklyn/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Brooklyn" | where: "city", "Wellington" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
