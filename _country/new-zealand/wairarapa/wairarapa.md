---
layout: page
title: Wairarapa, Wairarapa, New Zealand
country: New Zealand
region: Wairarapa
city: Wairarapa
permalink: /country/new-zealand/wairarapa/wairarapa/
---
[↑ Go to Wairarapa](/country/new-zealand/wairarapa/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wairarapa" | where: "city", "Wairarapa" %}
{% assign suburb_groups = posts | group_by: "suburb" %}
{% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

{% for group in sorted_suburb_groups %}
{% if group.name != "" %}
#### [{{ group.name }}](/country/new-zealand/wairarapa/{{ group.name | downcase | slugify }}/){: style="color: var(--heading-color);"}
{% else %}
#### Unspecified suburb
{% endif %}

{% assign rating_groups = group.items | group_by: "rating" %}
{% assign sorted_rating_groups = rating_groups | sort: "name" %}

{% for rating_group in sorted_rating_groups reversed %}
##### Rating: {{ rating_group.name }}

{% for post in rating_group.items %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

{% endfor %}
{% endfor %}
