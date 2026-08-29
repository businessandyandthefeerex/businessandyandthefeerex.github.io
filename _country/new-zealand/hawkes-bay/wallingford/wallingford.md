---
layout: page
title: Wallingford, Wallingford, Hawkes Bay, New Zealand
country: New Zealand
region: Hawkes Bay
suburb: Wallingford
city: Wallingford
permalink: /country/new-zealand/hawkes-bay/wallingford/wallingford/
---
[↑ Go to Wallingford](/country/new-zealand/hawkes-bay/wallingford/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Hawkes Bay" | where: "suburb", "Wallingford" | where: "city", "Wallingford" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
