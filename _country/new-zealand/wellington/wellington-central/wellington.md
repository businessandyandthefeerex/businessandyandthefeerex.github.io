---
layout: page
title: Wellington, Wellington Central, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Wellington Central
city: Wellington
permalink: /country/new-zealand/wellington/wellington-central/wellington/
---
[↑ Go to Wellington Central](/country/new-zealand/wellington/wellington-central/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Wellington Central" | where: "city", "Wellington" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
