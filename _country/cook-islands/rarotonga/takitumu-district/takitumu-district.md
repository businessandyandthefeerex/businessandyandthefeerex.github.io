---
layout: page
title: Takitumu District, Takitumu District, Rarotonga, Cook Islands
country: Cook Islands
region: Rarotonga
suburb: Takitumu District
city: Takitumu District
permalink: /country/cook-islands/rarotonga/takitumu-district/takitumu-district/
---
[↑ Go to Takitumu District](/country/cook-islands/rarotonga/takitumu-district/)

{% assign posts = site.posts | where: "country", "Cook Islands" | where: "region", "Rarotonga" | where: "suburb", "Takitumu District" | where: "city", "Takitumu District" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
