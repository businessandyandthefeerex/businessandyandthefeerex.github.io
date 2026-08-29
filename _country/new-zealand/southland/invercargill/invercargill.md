---
layout: page
title: Invercargill, Invercargill, Southland, New Zealand
country: New Zealand
region: Southland
suburb: Invercargill
city: Invercargill
permalink: /country/new-zealand/southland/invercargill/invercargill/
---
[↑ Go to Invercargill](/country/new-zealand/southland/invercargill/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Southland" | where: "suburb", "Invercargill" | where: "city", "Invercargill" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
#### Rating: {{ group.name }}

{% for post in group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
