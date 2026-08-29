---
layout: page
title: Swan Valley, Western Australia, Australia
country: Australia
region: Western Australia
city: Swan Valley
permalink: /country/australia/western-australia/swan-valley/
---
[↑ Go to Western Australia](/country/australia/western-australia/)

{% assign posts = site.posts | where: "country", "Australia" | where: "region", "Western Australia" | where: "city", "Swan Valley" %}
{% assign suburb_groups = posts | group_by: "suburb" %}
{% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

{% for group in sorted_suburb_groups %}
{% if group.name != "" %}
#### [{{ group.name }}](/country/australia/western-australia/{{ group.name | downcase | slugify }}/){: style="color: var(--heading-color);"}
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
