---
layout: page
title: Avarua, Avarua, Rarotonga, Cook Islands
country: Cook Islands
region: Rarotonga
suburb: Avarua
city: Avarua
permalink: /country/cook-islands/rarotonga/avarua/avarua/
---
[↑ Go to Avarua](/country/cook-islands/rarotonga/avarua/)

{% assign posts = site.posts | where: "country", "Cook Islands" | where: "region", "Rarotonga" | where: "suburb", "Avarua" | where: "city", "Avarua" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
