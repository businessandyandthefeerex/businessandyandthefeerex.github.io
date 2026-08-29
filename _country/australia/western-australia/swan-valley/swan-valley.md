---
layout: page
title: Swan Valley, Swan Valley, Western Australia, Australia
country: Australia
region: Western Australia
suburb: Swan Valley
city: Swan Valley
permalink: /country/australia/western-australia/swan-valley/swan-valley/
---
[↑ Go to Swan Valley](/country/australia/western-australia/swan-valley/)

{% assign posts = site.posts | where: "country", "Australia" | where: "region", "Western Australia" | where: "suburb", "Swan Valley" | where: "city", "Swan Valley" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
