---
layout: page
title: Feilding, Feilding, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Feilding
city: Feilding
permalink: /country/new-zealand/manawatu/feilding/feilding/
---
[↑ Go to Feilding](/country/new-zealand/manawatu/feilding/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Feilding" | where: "city", "Feilding" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
