---
layout: page
title: Manawatu, Manawatu, New Zealand
country: New Zealand
region: Manawatu
city: Manawatu
permalink: /country/new-zealand/manawatu/manawatu/
---
[↑ Go to Manawatu](/country/new-zealand/manawatu/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "city", "Manawatu" %}
{% assign suburb_groups = posts | group_by: "suburb" %}
{% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

{% for group in sorted_suburb_groups %}
{% if group.name != "" %}
#### [{{ group.name }}](/country/new-zealand/manawatu/{{ group.name | downcase | slugify }}/){: style="color: var(--heading-color);"}
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
