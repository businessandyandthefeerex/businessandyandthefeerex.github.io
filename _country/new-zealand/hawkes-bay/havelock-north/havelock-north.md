---
layout: page
title: Havelock North, Havelock North, Hawkes Bay, New Zealand
country: New Zealand
region: Hawkes Bay
suburb: Havelock North
city: Havelock North
permalink: /country/new-zealand/hawkes-bay/havelock-north/havelock-north/
---
[↑ Go to Havelock North](/country/new-zealand/hawkes-bay/havelock-north/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Hawkes Bay" | where: "suburb", "Havelock North" | where: "city", "Havelock North" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
