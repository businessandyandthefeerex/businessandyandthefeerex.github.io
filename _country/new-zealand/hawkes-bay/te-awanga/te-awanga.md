---
layout: page
title: Te Awanga, Te Awanga, Hawkes Bay, New Zealand
country: New Zealand
region: Hawkes Bay
suburb: Te Awanga
city: Te Awanga
permalink: /country/new-zealand/hawkes-bay/te-awanga/te-awanga/
---
[↑ Go to Te Awanga](/country/new-zealand/hawkes-bay/te-awanga/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Hawkes Bay" | where: "suburb", "Te Awanga" | where: "city", "Te Awanga" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
