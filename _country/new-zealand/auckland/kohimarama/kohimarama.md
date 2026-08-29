---
layout: page
title: Kohimarama, Kohimarama, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Kohimarama
city: Kohimarama
permalink: /country/new-zealand/auckland/kohimarama/kohimarama/
---
[↑ Go to Kohimarama](/country/new-zealand/auckland/kohimarama/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Kohimarama" | where: "city", "Kohimarama" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
