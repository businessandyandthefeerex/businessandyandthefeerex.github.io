---
layout: page
title: Roslyn, Roslyn, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Roslyn
city: Roslyn
permalink: /country/new-zealand/manawatu/roslyn/roslyn/
---
[↑ Go to Roslyn](/country/new-zealand/manawatu/roslyn/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Roslyn" | where: "city", "Roslyn" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
