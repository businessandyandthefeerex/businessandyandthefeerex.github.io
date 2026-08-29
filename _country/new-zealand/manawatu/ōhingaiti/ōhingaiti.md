---
layout: page
title: Ōhingaiti, Ōhingaiti, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Ōhingaiti
city: Ōhingaiti
permalink: /country/new-zealand/manawatu/ōhingaiti/ōhingaiti/
---
[↑ Go to Ōhingaiti](/country/new-zealand/manawatu/ōhingaiti/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Ōhingaiti" | where: "city", "Ōhingaiti" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
