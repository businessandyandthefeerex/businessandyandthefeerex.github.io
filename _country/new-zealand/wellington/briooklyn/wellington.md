---
layout: page
title: Wellington, Briooklyn, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Briooklyn
city: Wellington
permalink: /country/new-zealand/wellington/briooklyn/wellington/
---
[↑ Go to Briooklyn](/country/new-zealand/wellington/briooklyn/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Briooklyn" | where: "city", "Wellington" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
