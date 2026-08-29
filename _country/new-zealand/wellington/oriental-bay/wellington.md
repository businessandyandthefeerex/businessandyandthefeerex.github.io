---
layout: page
title: Wellington, Oriental Bay, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Oriental Bay
city: Wellington
permalink: /country/new-zealand/wellington/oriental-bay/wellington/
---
[↑ Go to Oriental Bay](/country/new-zealand/wellington/oriental-bay/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Oriental Bay" | where: "city", "Wellington" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
