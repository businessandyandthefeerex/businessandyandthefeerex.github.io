---
layout: page
title: Mount Maunganui, Mount Maunganui, Bay of Plenty, New Zealand
country: New Zealand
region: Bay of Plenty
suburb: Mount Maunganui
city: Mount Maunganui
permalink: /country/new-zealand/bay-of-plenty/mount-maunganui/mount-maunganui/
---
[↑ Go to Mount Maunganui](/country/new-zealand/bay-of-plenty/mount-maunganui/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Bay of Plenty" | where: "suburb", "Mount Maunganui" | where: "city", "Mount Maunganui" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
